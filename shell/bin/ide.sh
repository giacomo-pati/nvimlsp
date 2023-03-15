#bin/zsh
if [ -z "$TMUX" ]; then
		tmux new-session 'nvim;tmux kill-window' \; split-window -h -l 40% \; split-window -v -l 20% \; select-pane -L \;
else
		tmux split-window -h -l 40% \; split-window -v -l 20% \; select-pane -L \;
		tmux send-keys 'nvim;tmux kill-window' Enter
fi
