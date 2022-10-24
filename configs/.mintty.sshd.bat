@echo off
setlocal

C:\Windows\System32\netsh.exe interface portproxy delete v4tov4 listenport=22 listenaddress=0.0.0.0 protocol=tcp

for /f %%i in ('wsl hostname -I') do set IP=%%i
C:\Windows\System32\netsh.exe interface portproxy add v4tov4 listenport=22 listenaddress=0.0.0.0 connectport=22 connectaddress=%IP%

endlocal