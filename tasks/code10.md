# Binary code (10, 40, 4)
Find **40 binary words of length 10**, pairwise at Hamming distance at least **4**.

A(10,4) = 40 is exactly optimal, so there is no slack. Brute-force clique search over 1024 vertices
is hopeless; the way in is to impose a symmetry — insist the code is invariant under a cyclic shift,
and the search collapses to picking a handful of orbits.

## Submission format

```json
{"codewords": [[0,0,0,0,0,0,0,0,0,0], ...]}
```

## Checking

```bash
./verify.sh code10              # the fixtures, exactly as CI runs them
python3 code10/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

A(n,d) is known exactly for only a handful of parameters. **A(10,4) = 40 was settled by Best in 1978**; many nearby values, including A(18,6), remain open.
