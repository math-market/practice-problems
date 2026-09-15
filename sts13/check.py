#!/usr/bin/env python3
"""Steiner triple system on 13 points: triples from 0..12 with every
unordered pair in exactly one triple.

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

V = 13
tri = load("triples", list)
need = V*(V-1)//6
for t in tri:                                  # shape before count: a malformed triple is unreadable
    if not (isinstance(t, list) and len(t) == 3): bad("each triple must be a list of 3 points")
    if any(not isinstance(x, int) or not 0 <= x < V for x in t): bad("points must be integers in 0..%d" % (V-1))
if len(tri) != need: no("a Steiner triple system on %d points has %d triples; got %d" % (V, need, len(tri)))
seen = {}
for t in tri:
    if len(set(t)) != 3: no("triple %s repeats a point" % t)
    for a in range(3):
        for b in range(a+1, 3):
            p = tuple(sorted((t[a], t[b])))
            if p in seen: no("pair %s appears in more than one triple" % (list(p),))
            seen[p] = 1
if len(seen) != V*(V-1)//2: no("only %d of the %d pairs are covered" % (len(seen), V*(V-1)//2))
yes("Steiner triple system on 13 points: %d triples, every pair exactly once" % len(tri))
