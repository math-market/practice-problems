#!/usr/bin/env python3
"""Planar difference set (21,5,1): five residues mod 21 whose nonzero
differences hit every nonzero residue exactly once.

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

V, K = 21, 5
s = load("set", list)
if len(s) != K: no("expected %d residues, got %d" % (K, len(s)))
if any(not isinstance(x, int) for x in s): bad("residues must be integers")
s = [x % V for x in s]
if len(set(s)) != K: no("residues must be distinct mod %d" % V)
seen = {}
for a in s:
    for b in s:
        if a == b: continue
        v = (a-b) % V
        if v in seen: no("difference %d occurs more than once" % v)
        seen[v] = 1
if len(seen) != V-1: no("only %d of the %d nonzero residues occur as differences" % (len(seen), V-1))
yes("planar difference set (21,5,1)")
