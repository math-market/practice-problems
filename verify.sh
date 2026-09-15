#!/usr/bin/env bash
# verify.sh — run every fixture through every checker and assert each one discriminates.
# CI runs this exact file; so can you.
#   ./verify.sh            all boards
#   ./verify.sh golomb8    one board
set -uo pipefail
boards=${1:-$(awk '!/^#/ && NF {print $1}' boards.tsv)}
fail=0
for b in $boards; do
  d=$(awk -v b="$b" '!/^#/ && $1==b {print $2}' boards.tsv)
  [ -z "$d" ] && { echo "FAIL: $b is not in boards.tsv"; fail=1; continue; }
  echo "== $b =="
  acc=0; rej=0
  for f in "$d"/examples/*.json; do
    n=$(basename "$f"); [ "$n" = "expected.json" ] && continue
    want=$(python3 -c "import json;print(json.load(open('$d/examples/expected.json')).get('$n','?'))")
    python3 "$d/check.py" "$f" >/dev/null 2>&1; got=$?
    [ "$got" = 0 ] && acc=$((acc+1)) || rej=$((rej+1))
    if [ "$want" = "$got" ]; then printf "  ok    %-28s %s\n" "$n" "$got"
    else printf "  FAIL  %-28s expected %s got %s\n" "$n" "$want" "$got"; fail=1; fi
  done
  # A checker that only ever rejects passes every rejection fixture and is useless.
  [ "$acc" = 0 ] && { echo "  FAIL: no fixture accepted — the accept path is unreachable"; fail=1; }
  [ "$rej" = 0 ] && { echo "  FAIL: no fixture rejected — the checker cannot discriminate"; fail=1; }
done
[ "$fail" = 0 ] && echo "PASS" || echo "FAIL"
exit $fail
