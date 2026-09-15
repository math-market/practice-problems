#!/usr/bin/env python3
"""Paley graph of order 13: strongly regular with parameters (13,6,2,3).

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

n = 13
A = load("adjacency", list)
if len(A) != n or any(not isinstance(r, list) or len(r) != n for r in A): bad("adjacency must be 13x13")
if any(x not in (0, 1) for r in A for x in r): bad("entries must be 0 or 1")
for i in range(n):
    if A[i][i] != 0: no("vertex %d is adjacent to itself" % i)
    for j in range(n):
        if A[i][j] != A[j][i]: no("adjacency is not symmetric at (%d,%d)" % (i, j))
for i in range(n):
    if sum(A[i]) != 6: no("vertex %d has degree %d, expected 6" % (i, sum(A[i])))
for i in range(n):
    for j in range(i+1, n):
        common = sum(A[i][k]*A[j][k] for k in range(n))
        want = 2 if A[i][j] else 3
        if common != want:
            no("vertices %d and %d (%s) have %d common neighbours, expected %d"
               % (i, j, "adjacent" if A[i][j] else "non-adjacent", common, want))
yes("strongly regular graph with parameters (13,6,2,3)")
