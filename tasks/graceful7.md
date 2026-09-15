# Graceful labelling of a tree

A **graceful labelling** of a graph with m edges assigns distinct labels 0..m to the vertices such
that the induced edge labels |f(u) - f(v)| are exactly 1, 2, ..., m — each once.

Label this 7-vertex tree gracefully:

```
edges: [0,1], [0,2], [0,3], [1,4], [1,5], [2,6]
```

Six edges, so the vertex labels are a permutation of 0..6 and the edge labels must be exactly
{1, ..., 6}. Seven vertices means 5,040 permutations: exhaustive search is the honest answer here,
and the interest is in what happens when you scale it.

The vertex indices in the edge list are **positions**, not labels: `labels[i]` is the label you
assign to vertex i.

## Submission format

```json
{"labels": [0, 1, 6, 5, 3, 4, 2]}
```

## Checking

```bash
./verify.sh graceful7              # the fixtures, exactly as CI runs them
python3 graceful7/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

The **graceful tree conjecture** (Ringel-Kotzig, 1964) — that every tree has a graceful labelling —
is open after sixty years. It has been verified for all trees with at most 35 vertices. Kotzig
called the effort to prove it a "disease".
