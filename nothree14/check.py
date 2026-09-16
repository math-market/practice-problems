#!/usr/bin/env python3
"""No-three-in-line on a 14x14 grid: 20 points, no three collinear.

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

N, K = 14, 28
P = load("points", list)
for p in P:
    if not (isinstance(p, list) and len(p) == 2): bad("each point must be a list [row, col]")
    if any(not isinstance(x, int) or not 0 <= x < N for x in p): bad("coordinates must be integers 0..13")
if len(P) != K: no("expected %d points, got %d" % (K, len(P)))
pts = [tuple(p) for p in P]
if len(set(pts)) != K: no("points must be distinct")
for a, b, c in combinations(pts, 3):
    if (b[0]-a[0])*(c[1]-a[1]) == (c[0]-a[0])*(b[1]-a[1]):
        no("points %s, %s and %s are collinear" % (list(a), list(b), list(c)))
yes("20 points on the 14x14 grid with no three collinear")
