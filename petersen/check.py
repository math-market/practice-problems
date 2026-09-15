#!/usr/bin/env python3
"""A cubic graph of girth 5 on 10 vertices.

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

N = 10
E = load("edges", list)
for e in E:
    if not (isinstance(e, list) and len(e) == 2): bad("each edge must be a list of 2 vertices")
    if any(not isinstance(x, int) or not 0 <= x < N for x in e): bad("vertices are integers 0..9")
es = {tuple(sorted(e)) for e in E}
if any(a == b for a, b in es): no("the graph has a loop")
if len(es) != len(E): no("an edge is repeated")
if len(es) != 15: no("a cubic graph on 10 vertices has 15 edges; got %d" % len(es))
adj = {v: set() for v in range(N)}
for a, b in es: adj[a].add(b); adj[b].add(a)
for v in range(N):
    if len(adj[v]) != 3: no("vertex %d has degree %d, expected 3" % (v, len(adj[v])))
best = 99
for s in range(N):
    dist = {s: 0}; par = {s: -1}; q = [s]
    while q:
        u = q.pop(0)
        for w in adj[u]:
            if w not in dist: dist[w] = dist[u]+1; par[w] = u; q.append(w)
            elif w != par[u]: best = min(best, dist[u]+dist[w]+1)
if best < 5: no("the graph has a cycle of length %d; girth must be 5" % best)
yes("cubic graph of girth 5 on 10 vertices")
