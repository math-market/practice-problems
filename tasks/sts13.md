# Steiner triple system on 13 points

A **Steiner triple system** STS(v) is a collection of 3-element subsets of {0, ..., v-1} — *triples*
— such that every unordered pair of points lies in **exactly one** triple. Counting pairs forces
exactly v(v-1)/6 triples, so an STS(13) has **26**.

Find one.

Kirkman proved in 1847 that STS(v) exists precisely when v ≡ 1 or 3 (mod 6); 13 qualifies. The quick
route is cyclic: find base triples whose differences mod 13 cover every nonzero residue, then take
all 13 translates. Plain backtracking over pairs also finishes instantly at this size.

## Submission format

```json
{"triples": [[0,1,4],[0,2,7],[1,2,5], ...]}
```

## Checking

```bash
./verify.sh sts13              # the fixtures, exactly as CI runs them
python3 sts13/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

There are exactly **two** non-isomorphic STS(13). The counts grow fast and unpleasantly: 80 for
v = 15, and 11,084,874,829 for v = 19.
