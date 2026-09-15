#!/usr/bin/env python3
"""Binary code (10, 40, 4): forty codewords of length ten, minimum
Hamming distance four.

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

N, M, DMIN = 10, 40, 4
C = load("codewords", list)
for w in C:
    if not (isinstance(w, list) and len(w) == N): bad("each codeword must be a list of %d bits" % N)
    if any(x not in (0, 1) for x in w): bad("bits must be 0 or 1")
if len(C) != M: no("expected %d codewords, got %d" % (M, len(C)))
ws = [tuple(w) for w in C]
if len(set(ws)) != M: no("codewords must be distinct")
for i in range(M):
    for j in range(i+1, M):
        d = sum(a != b for a, b in zip(ws[i], ws[j]))
        if d < DMIN: no("codewords %d and %d are at distance %d; minimum is %d" % (i, j, d, DMIN))
yes("binary code (10, 40, 4)")
