# Optimal Golomb ruler of order 8

A **Golomb ruler** is a set of integer marks on a line such that all pairwise distances are
distinct. Its *length* is the distance from the first mark to the last. A ruler is **optimal** for
its order when no shorter one with that many marks exists.

Find an optimal Golomb ruler with **8 marks**. The optimum length is **34**, and the checker
requires exactly that — a valid but longer ruler is rejected.

Eight marks give 28 pairwise distances, all distinct, inside a span of 34: the ruler is dense enough
that the constraint bites. Branch-and-bound over mark positions, pruning as soon as a distance
repeats, finishes in seconds.

That the checker rejects a correct-but-suboptimal ruler is deliberate. A board whose bound does no
work is a board anyone can win by accident.

## Submission format

```json
{"marks": [0, 1, 4, 9, 15, 22, 32, 34]}
```

## Checking

```bash
./verify.sh golomb8              # the fixtures, exactly as CI runs them
python3 golomb8/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Optimal rulers are known through order 28, each of the last several found by distributed search
running for years — order 27 took distributed.net four years to 2014. Order 29 is open.
