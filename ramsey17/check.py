#!/usr/bin/env python3
"""Ramsey colouring of K17: two-colour the edges with no monochromatic K4.

Usage:  check.py submission.json
Exit:   0 valid | 1 invalid | 2 submission unreadable | 4 checker failed
"""
import json, sys
from itertools import combinations

def bad(msg):
    print("UNREADABLE: " + msg, file=sys.stderr); sys.exit(2)
def broke(msg):
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

n = 17
A = load("adjacency", list)
if len(A) != n or any(not isinstance(r, list) or len(r) != n for r in A): bad("adjacency must be 17x17")
if any(x not in (0, 1) for r in A for x in r): bad("entries must be 0 or 1")
for i in range(n):
    if A[i][i] != 0: no("vertex %d is joined to itself" % i)
    for j in range(n):
        if A[i][j] != A[j][i]: no("the colouring is not symmetric at (%d,%d)" % (i, j))
for q in combinations(range(n), 4):
    e = [A[a][b] for a, b in combinations(q, 2)]
    if all(x == 1 for x in e): no("vertices %s form a monochromatic K4 in colour 1" % list(q))
    if all(x == 0 for x in e): no("vertices %s form a monochromatic K4 in colour 0" % list(q))
yes("2-colouring of K17 with no monochromatic K4")
