# Costas array of order 17
A permutation p of {1,…,17} whose displacement vectors between pairs of dots are all distinct —
equivalently, for every shift h the differences p[i+h] − p[i] are pairwise distinct.

Welch's construction gives order p−1 for prime p, which misses 17. The **Lempel–Golomb**
construction gives order q−2 over GF(q): take q = 19 and solve gⁱ + gʲ = 1.

## Submission format

```json
{"permutation": [9,4,15,2,6,5,14,12,1,13,16,8,10,7,3,11,17]}
```

## Checking

```bash
./verify.sh costas17              # the fixtures, exactly as CI runs them
python3 costas17/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Costas arrays exist for every order up to 31. **Order 32 has been open since 1984** — neither construction reaches it.
