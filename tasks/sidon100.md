# Sidon set in [1,100]
A **Sidon set** has all pairwise differences distinct — equivalently, all pairwise sums distinct.
Find one of size **at least 12** inside [1,100], listed in increasing order.

Counting gives an immediate bound: k elements need k(k−1)/2 distinct positive differences, all at
most 99, so k(k−1) ≤ 198 and k ≤ 14. Getting to 12 by hand is awkward; a search with the difference
set carried along is the natural approach.

## Submission format

```json
{"set": [1,2,4,8,17,28,40,59,69,77,94,99]}
```

## Checking

```bash
./verify.sh sidon100              # the fixtures, exactly as CI runs them
python3 sidon100/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Erdős and Turán showed the maximum size in [1,n] is √n + O(n^(1/4)). **Erdős offered $500 for whether the error term is O(n^ε) for every ε > 0** — still unclaimed.
