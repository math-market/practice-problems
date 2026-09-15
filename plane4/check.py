#!/usr/bin/env python3
"""Projective plane of order 4: 21 lines of 5 points on 21 points,
every pair of points on exactly one line.

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

V, K = 21, 5
L = load("lines", list)
for l in L:
    if not (isinstance(l, list) and len(l) == K): bad("each line must be a list of %d points" % K)
    if any(not isinstance(x, int) or not 0 <= x < V for x in l): bad("points are integers 0..20")
if len(L) != V: no("a projective plane of order 4 has %d lines; got %d" % (V, len(L)))
for l in L:
    if len(set(l)) != K: no("line %s repeats a point" % l)
seen = {}
for l in L:
    for p in combinations(sorted(l), 2):
        if p in seen: no("points %s lie on more than one line" % list(p))
        seen[p] = 1
if len(seen) != V*(V-1)//2: no("only %d of the %d point pairs are covered" % (len(seen), V*(V-1)//2))
yes("projective plane of order 4")
