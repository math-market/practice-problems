#!/usr/bin/env python3
"""Optimal Golomb ruler of order 13: 13 marks, all distances distinct,
length exactly 106 (the known optimum).

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

ORDER, OPT = 13, 106
m = load("marks", list)
if any(not isinstance(x, int) or x < 0 for x in m): bad("marks must be non-negative integers")
if len(m) != ORDER: no("expected %d marks, got %d" % (ORDER, len(m)))
if len(set(m)) != ORDER: no("marks must be distinct")
m = sorted(m)
d = [m[j]-m[i] for i in range(ORDER) for j in range(i+1, ORDER)]
if len(set(d)) != len(d): no("two pairs of marks are the same distance apart")
if m[-1]-m[0] != OPT: no("length is %d; the optimal order-13 ruler has length %d" % (m[-1]-m[0], OPT))
yes("optimal Golomb ruler of order 13, length 106")
