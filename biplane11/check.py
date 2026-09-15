#!/usr/bin/env python3
"""Biplane (11,5,2): five residues mod 11 whose nonzero differences each
occur exactly twice.

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

V, K = 11, 5
s = load("set", list)
if any(not isinstance(x, int) for x in s): bad("residues must be integers")
if len(s) != K: no("expected %d residues, got %d" % (K, len(s)))
s = [x % V for x in s]
if len(set(s)) != K: no("residues must be distinct mod %d" % V)
cnt = {}
for a in s:
    for b in s:
        if a != b: cnt[(a-b) % V] = cnt.get((a-b) % V, 0) + 1
for v in range(1, V):
    if cnt.get(v, 0) != 2: no("difference %d occurs %d times, expected 2" % (v, cnt.get(v, 0)))
yes("biplane (11,5,2)")
