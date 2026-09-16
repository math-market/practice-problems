# Steiner triple system on 19 points

57 triples from {0,…,18} such that every one of the 171 pairs lies in exactly one triple.

Existence follows from Kirkman's 1847 condition (v ≡ 1 or 3 mod 6). Getting one out of a search
needs the pair-covering constraint propagated properly — pick the least uncovered pair and branch on
its third point.

## Submission format

```json
{"triples": [[0,1,2], ...]}
```

## Checking

```bash
./verify.sh sts19              # the fixtures, exactly as CI runs them
python3 sts19/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

There are **11,084,874,829** non-isomorphic STS(19), a count completed only in 2004 by Kaski and Östergård. For v = 21 the number is unknown.
