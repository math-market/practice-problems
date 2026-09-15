#!/usr/bin/env bash
# new-board.sh <board> — scaffold a board. See ADDING-A-BOARD.md for the procedure.
set -euo pipefail
b=${1:-}
[ -n "$b" ] || { echo "usage: ./new-board.sh <board-name>"; exit 1; }
[ -d "$b" ] && { echo "$b already exists"; exit 1; }
case "$b" in *[!a-z0-9]*) echo "board names are lowercase letters and digits only"; exit 1;; esac

mkdir -p "$b/examples"
cat > "$b/check.py" <<'PY'
#!/usr/bin/env python3
"""ONE-LINE STATEMENT OF THE PROBLEM.

Usage:  check.py submission.json
Exit:   0 valid | 1 invalid | 2 submission unreadable | 4 checker failed
"""
import json, sys

def bad(msg):          # the submission could not be read
    print("UNREADABLE: " + msg, file=sys.stderr); sys.exit(2)
def broke(msg):        # the checker itself failed — never a verdict
    print("CHECKER ERROR: " + msg, file=sys.stderr); sys.exit(4)
def no(msg):
    print("INVALID: " + msg); sys.exit(1)
def yes(msg):
    print("VALID: " + msg); sys.exit(0)

def load(field, kind):
    if len(sys.argv) != 2: bad("usage: check.py submission.json")
    try:
        d = json.load(open(sys.argv[1]))
    except FileNotFoundError: bad("no such file: " + sys.argv[1])
    except json.JSONDecodeError as e: bad("not valid JSON: %s" % e)
    if not isinstance(d, dict) or field not in d:
        bad("expected a JSON object with a %r field" % field)
    v = d[field]
    if not isinstance(v, kind): bad("%r must be %s" % (field, kind.__name__))
    return v

# Validate SHAPE first (exit 2), then CONTENT (exit 1). A malformed file must
# never be reported as a wrong answer. Exact arithmetic only — no floats.
value = load("FIELD", list)

# ... your check here; say WHY in every rejection ...

yes("DESCRIBE WHAT WAS VERIFIED")
PY

printf '{\n "valid.json": 0\n}\n' > "$b/examples/expected.json"

cat > "tasks/$b.md" <<'MD'
# TITLE

WHAT THE PROBLEM IS, and why it is interesting. Define the terms — write for someone who has not
seen it before.

## Submission format

```json
{"FIELD": ...}
```

WHAT THE FIELDS MEAN.

## Checking

```bash
./verify.sh BOARD              # the fixtures, exactly as CI runs them
python3 BOARD/check.py my.json   # your submission
```

## What is known

WHAT IS SETTLED, AND WHAT IS STILL OPEN.
MD
sed -i '' "s/BOARD/$b/g" "tasks/$b.md" 2>/dev/null || sed -i "s/BOARD/$b/g" "tasks/$b.md"

cat <<EOF

Scaffolded $b:
  $b/check.py            the checker  (exit contract already wired)
  $b/examples/           fixtures     (expected.json seeded with valid.json)
  tasks/$b.md            the board text

Now, in order — see ADDING-A-BOARD.md:
  1. SOLVE IT FIRST. Write a generator, get a real answer, save it as
     $b/examples/valid.json. A board nobody has solved may be impossible.
  2. Write the checker. Shape (exit 2) before content (exit 1).
  3. Add fixtures: a rejection, a malformed one, and a NEAR-MISS — an answer
     correct in every respect except the one this board turns on.
  4. Register it: boards.tsv, task.json tasks[] (with "nearMiss"), README.md.
  5. ./lint.sh && ./verify.sh $b
EOF
