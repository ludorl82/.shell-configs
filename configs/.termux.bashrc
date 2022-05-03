alias shell="ludorl82@shell.telepitpit.com"
alias console="if [[ \"$(ps ax | grep sshd | grep -v grep | wc -l)\" = \"0\" ]]; then sshd; fi; export ENV=console && export CLIENT=termux && ssh -p2222 -o SendEnv=ENV -o SendEnv=CLIENT -R 8022:localhost:8022 ludorl82@ssh.telepitpit.com"
alias vnc="vncserver --localhost"
