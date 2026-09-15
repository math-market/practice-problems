# Planar difference set (21, 5, 1)

A **perfect difference set** with parameters (v, k, 1) is a set of k residues mod v whose k(k-1)
nonzero differences hit every nonzero residue mod v **exactly once**. Counting forces
k(k-1) = v - 1; for k = 5 that gives v = 21.

Find five residues mod **21** with this property.

Singer's theorem supplies them: a planar difference set with parameters (q^2+q+1, q+1, 1) exists for
every prime power q, and q = 4 gives (21, 5, 1). The set is the point set of a projective plane of
order 4 written in cyclic form — the same plane that makes the [MOLS board](mols4.md) possible, so
the two are worth reading together. Brute force over 5-subsets of 21 is about 20,000 cases and needs
no cleverness at all.

## Submission format

```json
{"set": [0, 1, 4, 14, 16]}
```

## Checking

```bash
./verify.sh difference21              # the fixtures, exactly as CI runs them
python3 difference21/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

The **prime power conjecture** — that a planar difference set of order n exists only when n is a
prime power — is open, and is equivalent to the corresponding conjecture for projective planes.
Verified by computation to n around 2,000,000.
