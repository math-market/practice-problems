#!/usr/bin/env python3
"""Eleven points on a 1000x1000 integer grid, pairwise squared distance at
least 158272 — equivalently eleven non-overlapping circles in a square.

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

GRID, MIND2, N = 1000, 158272, 11
P = load("points", list)
for p in P:
    if not (isinstance(p, list) and len(p) == 2): bad("each point must be a list [x, y]")
    if any(not isinstance(v, int) or not 0 <= v <= GRID for v in p): bad("coordinates must be integers in 0..%d" % GRID)
if len(P) != N: no("expected %d points, got %d" % (N, len(P)))
if len({tuple(p) for p in P}) != N: no("points must be distinct")
worst = None
for a, b in combinations(P, 2):
    d2 = (a[0]-b[0])**2 + (a[1]-b[1])**2
    if worst is None or d2 < worst[0]: worst = (d2, a, b)
if worst[0] < MIND2:
    no("points %s and %s are at squared distance %d, below the required %d"
       % (worst[1], worst[2], worst[0], MIND2))
yes("eleven points with minimum squared distance %d/%d^2" % (worst[0], GRID))
