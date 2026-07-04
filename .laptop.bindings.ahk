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
