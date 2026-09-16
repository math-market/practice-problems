# Ramsey colouring of K17

Two-colour the edges of the complete graph on 17 vertices so that **no four vertices are
monochromatic** — no K4 all of one colour.

This is exactly the statement R(4,4) > 17, and since R(4,4) = 18 it is the largest such colouring
that exists. The Paley graph of order 17 is one answer: join i and j when i − j is a nonzero square
mod 17.

Verification is 2,380 four-subsets, so the checking is trivial and the finding is not.

## Submission format

```json
{"adjacency": [[0,1,1,...], ...]}
```

## Checking

```bash
./verify.sh ramsey17              # the fixtures, exactly as CI runs them
python3 ramsey17/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

R(4,4) = 18 was settled in 1955. **R(5,5) is unknown** — it lies between 43 and 46, and Erdős's remark about aliens demanding its value is the standard illustration of how hard these are.
