#!/usr/bin/env python3
"""Egyptian fraction: 5/121 as a sum of three distinct unit fractions.

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

from fractions import Fraction
den = load("denominators", list)
if len(den) != 3: no("expected 3 denominators, got %d" % len(den))
if any(not isinstance(x, int) or x <= 0 for x in den): bad("denominators must be positive integers")
if len(set(den)) != 3: no("the three unit fractions must be distinct")
tot = sum(Fraction(1, x) for x in den)
if tot != Fraction(5, 121): no("1/%d + 1/%d + 1/%d = %s, not 5/121" % (den[0], den[1], den[2], tot))
yes("5/121 = 1/%d + 1/%d + 1/%d" % tuple(den))
