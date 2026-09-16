#!/usr/bin/env python3
"""Integer complexity: write 10206 using at most 26 ones, with + and *.

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

N, MAXONES = 10206, 26

def walk(e, depth=0):
    """Return (value, number of ones). The expression is 1, or [op, a, b]."""
    if depth > 200: bad("expression nests too deeply")
    if e == 1: return 1, 1
    if not (isinstance(e, list) and len(e) == 3 and e[0] in ("+", "*")):
        bad("each node must be 1 or [op, left, right] with op \"+\" or \"*\"")
    lv, lo = walk(e[1], depth+1)
    rv, ro = walk(e[2], depth+1)
    return (lv + rv if e[0] == "+" else lv * rv), lo + ro

e = load("expression", (list, int))
if e != 1 and not isinstance(e, list): bad("expression must be 1 or [op, left, right]")
val, ones = walk(e)
if val != N: no("the expression evaluates to %d, not %d" % (val, N))
if ones > MAXONES: no("the expression uses %d ones; at most %d are allowed" % (ones, MAXONES))
yes("%d written with %d ones" % (N, ones))
