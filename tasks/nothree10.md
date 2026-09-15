# No-three-in-line on a 10×10 grid
Place **20 points** on the 10×10 grid so that no three are collinear. Two per row and two per
column is forced, since three in a row would be collinear.

Dudeney posed the problem in 1917. The collinearity test is an exact integer cross-product — no
floating point, so no near-misses from rounding.

## Submission format

```json
{"points": [[0,1],[0,3],[1,0], ...]}
```

## Checking

```bash
./verify.sh nothree10              # the fixtures, exactly as CI runs them
python3 nothree10/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

2n points are known to be achievable for n ≤ 46, but **whether 2n points exist for every n is open**. Heuristics suggest the true asymptotic density may be lower — around (π²/3)^(1/3)·n.
