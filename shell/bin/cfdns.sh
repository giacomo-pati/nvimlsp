#!/bin/bash
namepat="$1"
shift 1

echo flarectl dns "$@" --zone apps-dev.swissre.com flarectl
flarectl --json dns $@ --zone apps-dev.swissre.com \
| jq -r ".[] | select(.Name | contains(\"$namepat\")) | \"\(.ID),\(.Name),\(.Type),\(.Content),\(.TTL),\(.Proxied)\"" \
| column -t -s , -o "  " -N "ID,Name,Type,Content,TTL,Proxied"

