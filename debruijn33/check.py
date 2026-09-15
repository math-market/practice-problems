#!/usr/bin/env python3
"""De Bruijn sequence B(3,3): a cyclic ternary sequence of length 27
in which every 3-symbol word occurs exactly once.

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

N, K = 3, 3
seq = load("sequence", list)
if len(seq) != K**N: no("sequence has length %d; a B(3,3) sequence has length %d" % (len(seq), K**N))
if any(x not in (0, 1, 2) for x in seq): bad("entries must be 0, 1 or 2")
wins = [tuple(seq[(i+j) % len(seq)] for j in range(N)) for i in range(len(seq))]
if len(set(wins)) != K**N: no("the cyclic 3-windows are not all distinct")
yes("cyclic ternary sequence of length 27 containing all 27 three-symbol words exactly once")
