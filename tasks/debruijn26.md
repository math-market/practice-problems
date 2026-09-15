# De Bruijn sequence B(2,6)

A **de Bruijn sequence** B(k, n) is a cyclic string over a k-symbol alphabet in which every one of
the k^n possible n-symbol words appears exactly once as a contiguous cyclic substring. Its length is
therefore exactly k^n.

Find one for k = 2, n = 6: a cyclic binary sequence of length **64** containing each of the 64
six-bit words exactly once.

Two standard routes. Take an Eulerian circuit in the de Bruijn graph on 5-bit vertices — every such
circuit gives a sequence, and one exists because the graph is connected and balanced. Or concatenate
the binary Lyndon words whose length divides 6, in lexicographic order, which produces the
lexicographically least answer directly.

Note the sequence is **cyclic**: the window starting at position 62 wraps around to positions 0 and 1.

## Submission format

```json
{"sequence": [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, ...]}
```

## Checking

```bash
./verify.sh debruijn26              # the fixtures, exactly as CI runs them
python3 debruijn26/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Sequences exist for every k and n, and there are exactly 2^(2^(n-1) - n) of them in the binary case
— 2^26 = 67,108,864 for n = 6. Finding one is easy; the count is the pretty part.
