#Requires AutoHotkey v2.0

; Unstick Shift in case a prior run left it forced down
Send("{Shift up}")

^!#m::WinMaximize("A")
^Space::Send("{LWin down}{Space}{LWin up}")

; Emacs-style editing bindings
; InputLevel 1 so our own synthetic Sends (level 0) below don't re-trigger these
; Disabled while Alacritty is focused, so its shell handles these keys natively
#HotIf !WinActive("ahk_exe alacritty.exe")
; Word-wise navigation outside Alacritty (native Ctrl+Right/Left word jump)
^!f::Send("^{Right}")
^!b::Send("^{Left}")
!Backspace::Send("^{Backspace}")
#InputLevel 1
^a::Send("{Home}")
^e::Send("{End}")
^f::Send("{Right}")
^b::Send("{Left}")
^n::Send("{Down}")
^p::Send("{Up}")
^d::Send("{Delete}")
^h::Send("{Backspace}")
^w::Send("^{Backspace}")
^k:: {
    Send("+{End}")
    Send("^x")
}
#InputLevel 0
#HotIf

; Restore native Select All / Close on Ctrl+Shift
; (Send's own modifier handling releases/restores physically-held Shift safely)
^+a::Send("^a")
^+w::Send("^w")

; Windows can't reliably report Ctrl+Alt as distinct from AltGr to apps,
; so Alacritty never sees a clean Ctrl+Alt+B/F. Handle it here instead:
; release Alt, then send Escape + Ctrl+letter (what zsh's bindkey expects).
#HotIf WinActive("ahk_exe alacritty.exe")
^!b:: {
    Send("{Alt up}")
    Send("{Escape}")
    Send("^b")
}
^!f:: {
    Send("{Alt up}")
    Send("{Escape}")
    Send("^f")
}
#HotIf

; Virtual desktop switching, via VirtualDesktopAccessor.dll
; (https://github.com/Ciantic/VirtualDesktopAccessor, release 2024-12-16-windows11)
; expected alongside this script as VirtualDesktopAccessor.dll
VDA := A_ScriptDir "\VirtualDesktopAccessor.dll"
DllCall("LoadLibrary", "Str", VDA, "Ptr")

GetCurrentDesktopNumber() {
    global VDA
    return DllCall(VDA "\GetCurrentDesktopNumber", "Int")
}

GetDesktopCount() {
    global VDA
    return DllCall(VDA "\GetDesktopCount", "Int")
}

IsWindowOnDesktopNumber(hwnd, num) {
    global VDA
    return DllCall(VDA "\IsWindowOnDesktopNumber", "Ptr", hwnd, "Int", num, "Int")
}

IsCloaked(hwnd) {
    buf := Buffer(4, 0)
    DllCall("dwmapi\DwmGetWindowAttribute", "Ptr", hwnd, "Int", 14, "Ptr", buf, "Int", 4)
    return NumGet(buf, 0, "Int")
}

; DWM can report a cloaked (invisible) window as visible, so we filter those out
; along with owned/tool windows to land focus on the real top window, not a phantom one.
FocusTopWindowOnDesktop(num) {
    for hwnd in WinGetList() {
        try {
            if (WinGetTitle("ahk_id " hwnd) = "")
                continue
            if !DllCall("IsWindowVisible", "Ptr", hwnd)
                continue
            if IsCloaked(hwnd)
                continue
            if DllCall("GetWindow", "Ptr", hwnd, "UInt", 4, "Ptr")
                continue
            if (WinGetExStyle("ahk_id " hwnd) & 0x80)
                continue
            if WinGetMinMax("ahk_id " hwnd) = -1
                continue
            if IsWindowOnDesktopNumber(hwnd, num) {
                WinActivate("ahk_id " hwnd)
                return
            }
        }
    }
}

SwitchToDesktop(num) {
    global VDA
    DllCall(VDA "\GoToDesktopNumber", "Int", num, "Int")
    Sleep(50)
    FocusTopWindowOnDesktop(num)
}

GoToDesktop(n) {
    SwitchToDesktop(n - 1)
}

GoToPrevDesktop() {
    current := GetCurrentDesktopNumber()
    if (current > 0)
        SwitchToDesktop(current - 1)
}

GoToNextDesktop() {
    current := GetCurrentDesktopNumber()
    if (current < GetDesktopCount() - 1)
        SwitchToDesktop(current + 1)
}

^+1::GoToDesktop(1)
^+2::GoToDesktop(2)
^+3::GoToDesktop(3)
^+4::GoToDesktop(4)
^+5::GoToDesktop(5)

^!Left::GoToPrevDesktop()
^!Right::GoToNextDesktop()
