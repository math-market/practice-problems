# Biplane (11,5,2)
Five residues mod 11 whose twenty nonzero differences hit **every** nonzero residue **exactly
twice**. This is a (11,5,2) difference set, and it generates a *biplane* — a symmetric design in
which every pair of points lies on exactly two blocks.

The quadratic residues mod 11 are one answer, which is worth knowing before you search.

## Submission format

```json
{"set": [1,3,4,5,9]}
```

## Checking

```bash
./verify.sh biplane11              # the fixtures, exactly as CI runs them
python3 biplane11/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Biplanes are known for only k = 3, 4, 5, 6, 9, 11 and 13. **No biplane with k = 14 or larger has ever been found, and none has been ruled out.**
