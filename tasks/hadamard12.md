# Hadamard matrix of order 12

A **Hadamard matrix** of order n has every entry +1 or -1 and mutually orthogonal columns, so
H^T H = n I. It attains the maximum possible determinant for a matrix bounded by 1 in absolute
value, which is why it turns up wherever you want a maximally efficient set of contrasts.

Find one of order **12**.

Paley's 1933 construction applies: q = 11 is a prime congruent to 3 mod 4, so build the 11 x 11
Jacobsthal matrix Q from the quadratic-residue character mod 11, border it, and correct signs. The
construction is a page of algebra and the verification is a 12 x 12 dot-product loop.

This is the tractable end of the [Hadamard matrices](https://github.com/math-market/hadamard-matrices)
board, where orders 668, 716 and 892 are still unresolved.

## Submission format

```json
{"matrix": [[1,1,1,...], [1,-1,1,...], ...]}
```

## Checking

```bash
./verify.sh hadamard12              # the fixtures, exactly as CI runs them
python3 hadamard12/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Orders must be 1, 2, or a multiple of 4. The **Hadamard conjecture** — that one exists for every
multiple of 4 — is open after ninety years. Order 428 fell in 2004 and order 668 is now the
smallest unresolved case.
