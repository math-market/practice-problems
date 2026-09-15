# Paley graph of order 13
Build a graph on 13 vertices, joining i and j when i − j is a nonzero square mod 13, and verify it
is **strongly regular with parameters (13, 6, 2, 3)**: 6-regular, adjacent pairs sharing 2 common
neighbours, non-adjacent pairs sharing 3.

This board is as much about *checking* a property as finding an object — the construction takes one
line, the verification is the interesting part.

## Submission format

```json
{"adjacency": [[0,1,0,...], ...]}
```

## Checking

```bash
./verify.sh paley13              # the fixtures, exactly as CI runs them
python3 paley13/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Paley graphs are self-complementary and are conference graphs. Whether the Paley graph construction gives the only strongly regular graphs with these parameters depends on the order; for 13 it is unique.
