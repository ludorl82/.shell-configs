alias shell="ssh ludorl82@shell.telepitpit.com"
alias console="if [[ \"$(ps ax | grep sshd | grep -v grep | wc -l)\" = \"0\" ]]; then sshd; fi; export ENV=console && export CLIENT=termux && ssh -o SendEnv=ENV -o SendEnv=CLIENT -R 8022:localhost:8022 ludorl82@ludorl82-virtual-machine.local"
alias vnc="vncserver --localhost"
