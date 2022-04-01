#bin/zsh
tmux new-session 'nvim;tmux kill-session' \; split-window -h -l 40% \; split-window -v -l 20% \; select-pane -L \;
