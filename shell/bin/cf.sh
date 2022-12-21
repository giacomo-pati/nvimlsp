#!/bin/bash

namepat="$1"
tmp_file=$(mktemp)

echo flarectl d l --zone apps-dev.swissre.com
flarectl d l --zone apps-dev.swissre.com >"$tmp_file"
head -n2 <"$tmp_file"
grep "$namepat" <"$tmp_file"
rm -rf "$tmp_file"
