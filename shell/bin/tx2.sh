#bin/zsh
if [ -z "$TMUX" ]; then
	tmux new-session \; split-window -h -l 50% \; select-pane -L \;
else
	tmux split-window -h -l 50% \; select-pane -L \;
fi
