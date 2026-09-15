#!/usr/bin/env python3
"""Kirkman's schoolgirl problem: 15 girls walk in 5 triples on each of
7 days; every pair walks together exactly once.

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

V = 15
D = load("days", list)
for day in D:
    if not (isinstance(day, list) and len(day) == 5): bad("each day must be a list of 5 triples")
    for t in day:
        if not (isinstance(t, list) and len(t) == 3): bad("each triple must be a list of 3 girls")
        if any(not isinstance(x, int) or not 0 <= x < V for x in t): bad("girls are integers 0..14")
if len(D) != 7: no("expected 7 days, got %d" % len(D))
for i, day in enumerate(D):
    flat = sorted(x for t in day for x in t)
    if flat != list(range(V)):
        no("day %d does not split the 15 girls into 5 disjoint triples" % (i+1))
seen = {}
for day in D:
    for t in day:
        for p in combinations(sorted(t), 2):
            if p in seen: no("girls %s walk together more than once" % list(p))
            seen[p] = 1
if len(seen) != V*(V-1)//2: no("only %d of the %d pairs ever walk together" % (len(seen), V*(V-1)//2))
yes("Kirkman triple system: 7 days, every pair exactly once")
