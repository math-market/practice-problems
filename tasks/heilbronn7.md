# Heilbronn configuration, n = 7

Place seven points in the unit square so that **every triangle they form has large area**. The
Heilbronn triangle problem asks how large the smallest triangle can be forced to be.

To keep the criterion exact, points are given on a **1000×1000 integer grid** and the test is on twice
the area times 1000², which is an integer cross product — no floating point anywhere. You must
achieve a minimum cross product of at least **167268**, i.e. a minimum triangle area of
167268/2000000 ≈ 0.083634.

## Submission format

```json
{"points": [[0,0],[1000,417], ...]}
```

## Checking

```bash
./verify.sh heilbronn7              # the fixtures, exactly as CI runs them
python3 heilbronn7/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

The true optimum for n = 7 is about 0.083859, attained by an irrational configuration; the bound here is what a good search finds on this grid. **The asymptotic behaviour of the Heilbronn problem is open** — Goldberg's constructions and the Komlós–Pintz–Szemerédi bounds still leave a wide gap.
