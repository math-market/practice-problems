# Steiner triple system on 15 points
A **Steiner triple system** STS(v) is a collection of 3-element subsets of {0,…,v−1} — *triples* —
such that every unordered pair of points lies in **exactly one** triple. Counting pairs forces
exactly v(v−1)/6 triples, so an STS(15) has **35**.

Kirkman proved in 1847 that STS(v) exists precisely when v ≡ 1 or 3 (mod 6). One clean route: take
the 15 non-zero vectors of GF(2)⁴ as points and {a, b, a⊕b} as triples — that is the projective
space PG(3,2).

## Submission format

```json
{"triples": [[0,1,4], [0,2,7], ...]}
```

## Checking

```bash
./verify.sh sts15              # the fixtures, exactly as CI runs them
python3 sts15/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

There are exactly **80** non-isomorphic STS(15), against just two for v = 13. For v = 19 the count is 11,084,874,829.
