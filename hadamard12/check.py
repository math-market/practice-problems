#!/usr/bin/env python3
"""Hadamard matrix of order 12: entries +/-1 with H^T H = 12 I.

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
M = load("matrix", list)
if len(M) != n or any(not isinstance(r, list) or len(r) != n for r in M): bad("matrix must be %dx%d" % (n, n))
if any(x not in (1, -1) for r in M for x in r): no("every entry must be +1 or -1")
for i in range(n):
    for j in range(n):
        d = sum(M[k][i]*M[k][j] for k in range(n))
        want = n if i == j else 0
        if d != want: no("columns %d and %d have inner product %d, expected %d" % (i, j, d, want))
yes("Hadamard matrix of order 12")
