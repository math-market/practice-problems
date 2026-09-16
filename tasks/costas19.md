# Costas array of order 19

Find a **Costas array of order 19**: a permutation p of {1,…,19} whose displacement vectors between
pairs of dots are all distinct — equivalently, one for which the differences p[i+h] − p[i] are
pairwise distinct at every shift h.

**Order 19 is the hard one.** Welch's construction gives order p−1 for prime p, and the Lempel and
Golomb constructions give q−2 and q−3 over GF(q). None of them lands on 19, and the usual trick of
peeling a corner off a larger array does not reach it either — the corner is only removable when it
holds the smallest value, and for the order-21 and order-22 arrays here it does not. So this one has
to be searched for, with the difference triangle maintained incrementally or the search will not
finish.

## Submission format

```json
{"permutation": [1, 2, 13, 7, ...]}
```

## Checking

```bash
./verify.sh costas19              # the fixtures, exactly as CI runs them
python3 costas19/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Costas arrays are known for every order up to 31, but only because search filled the gaps the
algebraic constructions leave. **Order 32 has been open since 1984** — no construction reaches it,
and exhaustive search was estimated at 45,000 processor-years in 2011. Whether Costas arrays exist
for all orders is open.
