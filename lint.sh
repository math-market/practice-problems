#!/usr/bin/env bash
# lint.sh — structural invariants for this repository.
#
# verify.sh proves each checker WORKS. lint.sh proves each board is COMPLETE:
# every piece a board needs exists, is registered, and is consistent with the
# others. Adding a board without these is the failure mode this file exists to
# stop — a board is easy to half-add, and a half-added board looks fine until a
# solver hits it.
#
# CI runs this before verify.sh.
set -uo pipefail
fail=0
err() { printf "  FAIL  %s\n" "$1"; fail=1; }

boards=$(awk '!/^#/ && NF {print $1}' boards.tsv)
echo "== structure =="
for b in $boards; do
  d=$(awk -v b="$b" '!/^#/ && $1==b {print $2}' boards.tsv)
  [ -d "$d" ]                      || err "$b: directory '$d' does not exist"
  [ -f "$d/check.py" ]             || err "$b: no $d/check.py"
  [ -f "$d/examples/expected.json" ] || err "$b: no $d/examples/expected.json"
  [ -f "tasks/$b.md" ]             || err "$b: no tasks/$b.md (the board text solvers read)"
  grep -q "tasks/$b.md" README.md  || err "$b: not listed in README.md"
done

# Every fixture has a declared expectation, and every expectation has a fixture.
echo "== fixtures =="
for b in $boards; do
  d=$(awk -v b="$b" '!/^#/ && $1==b {print $2}' boards.tsv)
  [ -f "$d/examples/expected.json" ] || continue
  out=$(python3 - "$b" "$d" <<'PY'
import json,os,sys
b,d=sys.argv[1],sys.argv[2]
exp=json.load(open(f"{d}/examples/expected.json"))
have={f for f in os.listdir(f"{d}/examples") if f.endswith(".json") and f!="expected.json"}
for f in sorted(have-set(exp)): print(f"{b}: fixture {f} has no entry in expected.json")
for f in sorted(set(exp)-have): print(f"{b}: expected.json names {f}, which does not exist")
if 0 not in exp.values(): print(f"{b}: no fixture is expected to be ACCEPTED (exit 0)")
if 1 not in exp.values(): print(f"{b}: no fixture is expected to be REJECTED (exit 1)")
for f,c in sorted(exp.items()):
    if c not in (0,1,2,4): print(f"{b}: {f} expects exit {c}; the contract is 0/1/2/4")
PY
)
  [ -n "$out" ] && while read -r l; do err "$l"; done <<< "$out"
done

# The Golay lesson, made mechanical. A board that states a bound must ship the
# near-miss the bound excludes -- an answer correct in every other respect. A
# fixture that fails for some other reason tests nothing, and looks identical
# in CI to one that works. Where no such near-miss can exist, say so and why.
echo "== near-misses =="
out=$(python3 - <<'PY'
import json,os,subprocess,sys
man={t["board"]: t for t in json.load(open("task.json"))["tasks"]}
rows=[l.split("\t") for l in open("boards.tsv") if l.strip() and not l.startswith("#")]
for r in rows:
    b,d=r[0],r[1]
    t=man.get(b)
    if t is None: print(f"{b}: not listed in task.json tasks[]"); continue
    nm, waiver = t.get("nearMiss"), t.get("nearMissWaiver")
    if nm is None and not waiver:
        print(f"{b}: declares neither a nearMiss fixture nor a nearMissWaiver explaining why none exists")
        continue
    if nm is None: continue
    p=f"{d}/examples/{nm}"
    if not os.path.exists(p): print(f"{b}: nearMiss {nm} does not exist"); continue
    code=subprocess.run([sys.executable,f"{d}/check.py",p],capture_output=True).returncode
    if code!=1: print(f"{b}: nearMiss {nm} exits {code}; a near-miss must be REJECTED (1)")
PY
)
[ -n "$out" ] && while read -r l; do err "$l"; done <<< "$out"

# Every board must be reachable through the dispatcher the sandbox uses.
echo "== manifest =="
for b in $boards; do
  python3 -c "
import json,sys
m={t['board'] for t in json.load(open('task.json'))['tasks']}
sys.exit(0 if '$b' in m else 1)" || err "$b: missing from task.json tasks[]"
done
python3 -c "import json;json.load(open('task.json'))" 2>/dev/null || err "task.json is not valid JSON"

[ "$fail" = 0 ] && echo "PASS — $(echo "$boards" | wc -w | tr -d ' ') boards complete" || echo "FAIL"
exit $fail
