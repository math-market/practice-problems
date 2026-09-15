#!/usr/bin/env python3
"""Sidon set in [1,100] of size at least 12: all pairwise differences distinct.

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

LO, HI, MIN = 1, 100, 12
s = load("set", list)
if any(not isinstance(x, int) for x in s): bad("entries must be integers")
if any(not LO <= x <= HI for x in s): no("every element must lie in [%d, %d]" % (LO, HI))
if len(set(s)) != len(s): no("elements must be distinct")
if len(s) < MIN: no("the set has %d elements; at least %d are required" % (len(s), MIN))
t = sorted(s)
d = [b-a for i, a in enumerate(t) for b in t[i+1:]]
if len(set(d)) != len(d):
    rep = next(x for x in d if d.count(x) > 1)
    no("difference %d occurs more than once; a Sidon set has all differences distinct" % rep)
yes("Sidon set of size %d in [1,100]" % len(s))
