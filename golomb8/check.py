#!/usr/bin/env python3
"""Optimal Golomb ruler of order 8: 8 marks, all pairwise distances
distinct, total length exactly 34 (the known optimum).

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

ORDER, OPT = 8, 34
m = load("marks", list)
if len(m) != ORDER: no("expected %d marks, got %d" % (ORDER, len(m)))
if any(not isinstance(x, int) or x < 0 for x in m): bad("marks must be non-negative integers")
if len(set(m)) != ORDER: no("marks must be distinct")
m = sorted(m)
d = [m[j]-m[i] for i in range(ORDER) for j in range(i+1, ORDER)]
if len(set(d)) != len(d): no("two pairs of marks are the same distance apart; a Golomb ruler has all distances distinct")
L = m[-1]-m[0]
if L != OPT: no("length is %d; the optimal order-%d ruler has length %d" % (L, ORDER, OPT))
yes("optimal Golomb ruler of order 8, length 34")
