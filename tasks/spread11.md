# Eleven points spread in a square

Place eleven points in the unit square so that **no two are close together** — equivalently, pack
eleven equal non-overlapping circles into a square as tightly as possible.

Points are on a **1000×1000 integer grid** and the test is on squared distance, so the arithmetic is
exact integers. You must achieve a minimum squared distance of at least **158272**, i.e. a minimum
separation of about 0.39783.

## Submission format

```json
{"points": [[0,0],[398,0], ...]}
```

## Checking

```bash
./verify.sh spread11              # the fixtures, exactly as CI runs them
python3 spread11/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

The optimal separation for 11 points is about 0.39804, proved optimal by Melissen in 1994. **Most cases beyond n = 30 are only conjectural** — the packings are known numerically but not proved.
