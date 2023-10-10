#bin/zsh
if [ -z "$TMUX" ]; then
	tmux new-session \; split-window -v -l 50% \;
else
	tmux split-window -v -l 50% \;
fi
