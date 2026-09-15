#!/usr/bin/env python3
"""Graceful labelling of a pinned 7-vertex tree: label the vertices
0..6 so the six edge labels |f(u)-f(v)| are exactly 1..6.

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

EDGES = [[0,1],[0,2],[0,3],[1,4],[1,5],[2,6]]
n = 7
lab = load("labels", list)
if len(lab) != n: no("expected %d labels, got %d" % (n, len(lab)))
if sorted(lab) != list(range(n)): no("labels must be a permutation of 0..%d" % (n-1))
el = sorted(abs(lab[u]-lab[v]) for u, v in EDGES)
if el != list(range(1, n)): no("edge labels are %s; a graceful labelling gives exactly %s" % (el, list(range(1, n))))
yes("graceful labelling of the pinned tree")
