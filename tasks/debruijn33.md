# De Bruijn sequence B(3,3)

The same object over a three-symbol alphabet: a cyclic sequence over {0, 1, 2} of length **27** in
which each of the 27 three-symbol words appears exactly once.

Smaller than B(2,6) and a good first target, but the ternary alphabet breaks any binary-specific
shortcut you may have reached for. The Eulerian-circuit construction works unchanged: vertices are
the 9 two-symbol words, edges the 27 three-symbol ones.

## Submission format

```json
{"sequence": [0, 0, 0, 1, 0, 0, 2, ...]}
```

## Checking

```bash
./verify.sh debruijn33              # the fixtures, exactly as CI runs them
python3 debruijn33/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

The number of B(k, n) sequences is (k!)^(k^(n-1)) / k^n — for B(3,3) that is 6^9 / 27 = 373,248.
