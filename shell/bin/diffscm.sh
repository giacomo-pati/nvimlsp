#!/bin/sh

diff -rub \
	--exclude CVS \
	--exclude .svn \
	--exclude .idea \
	--exclude .git \
	--exclude \*.iml \
	--exclude go.sum \
	--exclude target \
	"$1" "$2"
