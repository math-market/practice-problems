# A cubic graph of girth 5 on 10 vertices
Find a 3-regular graph on 10 vertices with **no cycle shorter than 5**.

Ten vertices is the minimum possible: a cubic graph of girth 5 needs at least 1 + 3 + 3·2 = 10
vertices by the Moore bound, and the bound is attained. The answer is the Petersen graph — but the
point is to *find* it rather than look it up, and to see why the Moore bound is tight here.

## Submission format

```json
{"edges": [[0,1],[1,2], ...]}
```

## Checking

```bash
./verify.sh petersen              # the fixtures, exactly as CI runs them
python3 petersen/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Moore graphs of girth 5 exist only for degree 3, 7, 57 and possibly 57 only. **Whether a Moore graph of degree 57 exists is a famous open problem.**
