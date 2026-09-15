# Hadamard matrix of order 28
Entries ±1, columns mutually orthogonal, so HᵀH = 28·I.

Paley's first construction applies: 27 = 3³ is a prime power ≡ 3 (mod 4), so build the 27×27
Jacobsthal matrix from the quadratic-residue character of **GF(27)**, border it, and add the
identity. Doing so means constructing GF(27) itself — arithmetic modulo an irreducible cubic over
GF(3) — which is the real content of this board.

## Submission format

```json
{"matrix": [[1,1,...], [1,-1,...], ...]}
```

## Checking

```bash
./verify.sh hadamard28              # the fixtures, exactly as CI runs them
python3 hadamard28/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

The **Hadamard conjecture** — that one exists for every multiple of 4 — is open after ninety years. Order 668 is the smallest unresolved case and is a live board on this platform.
