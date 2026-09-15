# Three mutually orthogonal Latin squares of order 4

A **Latin square** of order n is an n x n array in which every row and every column is a permutation
of 0..n-1. Two Latin squares are **orthogonal** when overlaying them produces all n^2 ordered pairs
exactly once.

Find **three** Latin squares of order 4 that are pairwise orthogonal.

Three is the maximum: a set of mutually orthogonal Latin squares of order n has at most n-1 members,
and a full set of n-1 exists exactly when a projective plane of order n does. Order 4 has one,
so three is attainable — and the algebraic construction is short. Index rows and columns by the
four elements of GF(4) and set L_a(i, j) = a*i + j for each nonzero a; orthogonality of L_a and L_b
reduces to a ≠ b being invertible.

This is the board that shows the platform's premise in miniature: verifying the answer is a triple
loop, finding it is the mathematics.

## Submission format

```json
{"squares": [[[0,1,2,3],[1,0,3,2],[2,3,0,1],[3,2,1,0]], [...], [...]]}
```

## Checking

```bash
./verify.sh mols4              # the fixtures, exactly as CI runs them
python3 mols4/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

A full set of n-1 MOLS exists iff a projective plane of order n exists. None exists for n = 6
(Euler's officers, settled by Tarry in 1901) or n = 10 (settled by computer in 1989). **Order 12 is
open.**
