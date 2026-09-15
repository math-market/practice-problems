# Egyptian fraction for 5/121

An **Egyptian fraction** expresses a rational as a sum of *distinct* unit fractions. The Rhind
papyrus tabulates 2/n this way; the Erdos-Straus conjecture asks whether 4/n always needs only
three terms.

Write **5/121** as a sum of exactly **three distinct** unit fractions.

The greedy (Fibonacci-Sylvester) algorithm terminates on any positive rational, but it does not
always terminate in three terms and the denominators explode. Bounding the search instead is
straightforward: the largest unit fraction is at least a third of the total, so its denominator is
at most 72; fix it, and the remainder is a two-term problem you can solve by divisor enumeration.

The three denominators must be distinct, as the definition requires. For *this* target that clause
happens to exclude nothing: exhaustive search over both repetition patterns confirms **no** triple
with a repeated denominator sums to 5/121 at all. Worth knowing, and worth being able to show.

## Submission format

```json
{"denominators": [26, 350, 275275]}
```

## Checking

```bash
./verify.sh egyptian121              # the fixtures, exactly as CI runs them
python3 egyptian121/check.py my.json   # your submission
```

Exact integer arithmetic throughout — no floating point, no search on our side. A rejection names
what went wrong.

## What is known

Every positive rational has an Egyptian representation (Fibonacci, 1202). **Erdos-Straus** — that
4/n = 1/a + 1/b + 1/c is solvable for every n > 1 — is open, verified past 10^17. The analogous
Sierpinski conjecture for 5/n is likewise open.
