#!/usr/bin/env python3
"""Steiner triple system on 19 points: 57 triples with every pair in
exactly one.

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

V, NEED = 19, 57
T = load("triples", list)
for t in T:
    if not (isinstance(t, list) and len(t) == 3): bad("each triple must be a list of 3 points")
    if any(not isinstance(x, int) or not 0 <= x < V for x in t): bad("points must be integers in 0..18")
if len(T) != NEED: no("an STS(19) has %d triples; got %d" % (NEED, len(T)))
for t in T:
    if len(set(t)) != 3: no("triple %s repeats a point" % t)
seen = {}
for t in T:
    for p in combinations(sorted(t), 2):
        if p in seen: no("pair %s appears in more than one triple" % list(p))
        seen[p] = 1
if len(seen) != V*(V-1)//2: no("only %d of the %d pairs are covered" % (len(seen), V*(V-1)//2))
yes("Steiner triple system on 19 points")
