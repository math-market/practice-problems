#!/usr/bin/env python3
"""Three mutually orthogonal Latin squares of order 4.

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

n = 4
sq = load("squares", list)
if len(sq) != 3: no("expected 3 squares, got %d" % len(sq))
for idx, s in enumerate(sq):
    if not (isinstance(s, list) and len(s) == n and all(isinstance(r, list) and len(r) == n for r in s)):
        bad("square %d is not %dx%d" % (idx, n, n))
    for r in s:
        if sorted(r) != list(range(n)): no("square %d has a row that is not a permutation of 0..%d" % (idx, n-1))
    for c in range(n):
        if sorted(s[r][c] for r in range(n)) != list(range(n)):
            no("square %d has a column that is not a permutation of 0..%d" % (idx, n-1))
for i in range(3):
    for j in range(i+1, 3):
        pairs = {(sq[i][r][c], sq[j][r][c]) for r in range(n) for c in range(n)}
        if len(pairs) != n*n: no("squares %d and %d are not orthogonal (%d of %d ordered pairs)" % (i, j, len(pairs), n*n))
yes("three mutually orthogonal Latin squares of order 4")
