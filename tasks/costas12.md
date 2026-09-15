# Costas array of order 12

A **Costas array** of order n is a permutation p of {1, ..., n} — dots at (column i, row p[i]) —
whose n(n-1)/2 displacement vectors between pairs of dots are all distinct. Equivalently, for every
horizontal shift h the differences p[i+h] - p[i] are pairwise distinct.

Find one of order **12**.

Both algebraic constructions reach it. Welch: pick a primitive root g modulo the prime 13 and set
p[i] = g^i mod 13, which lands in 1..12 automatically. Golomb: use a primitive element of a finite
field. Exhaustive search also finishes quickly at this order.

Costas arrays give radar and sonar waveforms with an ideal ambiguity function — any shift in time
and frequency coincides with at most one other dot, so range and Doppler are unambiguous.

## Submission format

```json
{"permutation": [2, 4, 8, 3, 6, 12, 11, 9, 5, 10, 7, 1]}
```

## Checking

```bash
./verify.sh costas12              # the fixtures, exactly as CI runs them
python3 costas12/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Costas arrays exist for every order up to 31. **Order 32 has been open since 1984** — neither
construction reaches it, and exhaustive search was estimated at 45,000 processor-years in 2011. See
the [costas-arrays](https://github.com/math-market/costas-arrays) board.

Note the submission format here differs from that board: this one takes `permutation`, that one
takes `n` and `p`.
