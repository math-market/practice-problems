# Projective plane of order 4
A **projective plane of order n** has n²+n+1 points and as many lines, each line holding n+1
points, with every pair of points on exactly one line. For n = 4 that is **21 points, 21 lines and 5
points per line**, with every one of the 210 point-pairs covered exactly once.

The quickest construction is cyclic: a planar difference set (21,5,1) and all of its 21 translates
mod 21. That difference set is exactly the `difference21` board.

## Submission format

```json
{"lines": [[0,1,4,14,16], ...]}
```

## Checking

```bash
./verify.sh plane4              # the fixtures, exactly as CI runs them
python3 plane4/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

A plane of order n is known for every prime power n. **Order 10 was ruled out by computer in 1989**; order 12 is open, and no plane of non-prime-power order has ever been found.
