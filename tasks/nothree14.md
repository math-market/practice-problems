# No-three-in-line on a 14×14 grid

Place **28 points** on the 14×14 grid so that no three are collinear. Two per row and two per
column are forced, since three in any row would be collinear.

This is the same problem as the 10×10 board and a very different computation. Randomised
row-by-row backtracking solves 10×10 in seconds and does not finish on 14×14 at all — the search is
heavy-tailed, so the fix is aggressive restarts with a small node budget rather than one long run.
Imposing 180° symmetry is the other standard lever, though the solution here is not symmetric.

Dudeney posed the problem in 1917. The collinearity test is an exact integer cross product, so
there are no near-misses from rounding.

## Submission format

```json
{"points": [[0,1],[0,3],[1,0], ...]}
```

## Checking

```bash
./verify.sh nothree14              # the fixtures, exactly as CI runs them
python3 nothree14/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

2n points are known to be achievable for n ≤ 46, but **whether 2n points exist for every n is
open**. Heuristic arguments suggest the true asymptotic density may be lower — around
(π²/3)^(1/3)·n ≈ 1.874n — so the pattern is expected to break eventually, and nobody knows where.
