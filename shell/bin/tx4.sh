#bin/zsh
if [ -z "$TMUX" ]; then
	tmux new-session \; split-window -h -l 50% \; split-window -v -l 50% \;  select-pane -L \; split-window -v -l 50% \; select-pane -U
else
	tmux split-window -h -l 50% \; split-window -v -l 50% \;  select-pane -L \; split-window -v -l 50% \; select-pane -U
fi
