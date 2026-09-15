#!/bin/sh
# run.sh <board> <submission.json> — dispatch to that board's checker.
[ $# -eq 2 ] || { echo "UNREADABLE: usage: run.sh <board> <submission.json>" >&2; exit 2; }
c="/task/checkers/$1.py"
[ -f "$c" ] || { echo "CHECKER ERROR: no such board: $1" >&2; exit 4; }
exec python3 "$c" "$2"
