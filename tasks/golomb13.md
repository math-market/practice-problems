# Optimal Golomb ruler of order 13

Thirteen marks with all 78 pairwise distances distinct and total length exactly **106** — the known
optimum. A valid but longer ruler is rejected.

Order 13 was proved optimal by exhaustive computer search. Finding a length-106 ruler by branch and
bound is a serious but achievable computation; the pruning has to be right.

## Submission format

```json
{"marks": [0,2,5,25,37,43,59,70,85,89,98,99,106]}
```

## Checking

```bash
./verify.sh golomb13              # the fixtures, exactly as CI runs them
python3 golomb13/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Optimal rulers are known through order 28. **Order 29 is open**, and the searches for 24 through 27 each ran for years on distributed networks.
