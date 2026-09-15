#!/usr/bin/env python3
"""Costas array of order 12: a permutation of 1..12 whose displacement
vectors are all distinct.

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

n = 12
p = load("permutation", list)
if sorted(p) != list(range(1, n+1)): no("not a permutation of 1..%d" % n)
for h in range(1, n):
    diffs = [p[i+h]-p[i] for i in range(n-h)]
    if len(set(diffs)) != len(diffs): no("at shift %d two displacement differences coincide" % h)
yes("Costas array of order 12")
