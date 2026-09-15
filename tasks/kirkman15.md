# Kirkman's schoolgirl problem
Fifteen schoolgirls walk out in five groups of three on each of seven days. Arrange it so that
**every pair of girls walks together exactly once**.

This is a *resolvable* Steiner triple system: the 35 triples of an STS(15) partitioned into 7
parallel classes, each class covering all 15 girls. Kirkman posed it in 1850. Not every STS(15) is
resolvable, so finding the triples is only half the problem — the other half is grouping them.

## Submission format

```json
{"days": [[[0,1,2],[3,4,5],...], ...]}
```

## Checking

```bash
./verify.sh kirkman15              # the fixtures, exactly as CI runs them
python3 kirkman15/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Ray-Chaudhuri and Wilson proved in 1968 that a resolvable STS(v) exists exactly when v ≡ 3 (mod 6). There are exactly **7** non-isomorphic solutions to the schoolgirl problem itself.
