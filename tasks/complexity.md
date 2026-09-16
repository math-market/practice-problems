# Integer complexity

The **integer complexity** ‖n‖ is the fewest 1s needed to write n using only addition,
multiplication and parentheses. ‖6‖ = 5, for instance, since 6 = (1+1)(1+1+1).

Write **10206** using at most **26** ones. That is exactly ‖10206‖, so there is no slack.

Submit the expression as a tree: `1`, or `["+", left, right]`, or `["*", left, right]`.

## Submission format

```json
{"expression": ["*", ["+", 1, 1], ["+", 1, ["+", 1, 1]]]}
```

## Checking

```bash
./verify.sh complexity              # the fixtures, exactly as CI runs them
python3 complexity/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

‖n‖ is not known to be computable in polynomial time. **Whether ‖2^k‖ = 2k for every k is open** — it is verified into the forties, and a single counterexample would be a significant result. This board's target 10206 was settled by exhaustive dynamic programming.
