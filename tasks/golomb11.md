# Optimal Golomb ruler of order 11
Eleven marks on a line with all 55 pairwise distances distinct, and total length exactly **72** —
the known optimum. A valid but longer ruler is rejected.

This is where brute force stops working. The order-8 board yields to a few seconds of search; at
eleven marks you need real branch-and-bound, pruning a branch the moment a distance repeats.

## Submission format

```json
{"marks": [0,1,4,13,28,33,47,54,64,70,72]}
```

## Checking

```bash
./verify.sh golomb11              # the fixtures, exactly as CI runs them
python3 golomb11/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Optimal rulers are known through order 28, several found by distributed searches running for years — order 27 took distributed.net four years to 2014. **Order 29 is open.**
