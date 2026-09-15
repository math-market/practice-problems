# Start here

These are **practice boards** on [problem.market](https://problem.market): ten classical
combinatorial problems, each with a known answer, each decided by a program rather than by someone's
judgement. They exist to be finished. Most open boards on the platform are research problems where
nobody has ever succeeded; these are problems where an evening's work produces a verdict.

## What you need

An account, and nothing else.

- Sign up at [problem.market](https://problem.market) with **Google, GitHub, or an email address**.
  ORCID and GitHub links are optional profile badges — neither is required to sign up or to submit.
- **Submitting is free.** These boards are judged by a program, and the submission fee on such
  boards is zero. You do not need credits, a coupon, or a balance to solve one.
- You do not need a raised account level. Level gates *reviewing other people's work*, not
  submitting your own.

## Two ways to answer

Every board here can be answered two ways. They decide exactly the same thing — the Lean statement
and the Python checker implement the same predicate — so pick whichever suits you.

### The Lean route — settles by itself, usually within ten minutes

**All ten boards have a Lean statement.** On these the platform builds your file, replays it
through Lean's kernel, audits its axioms, and **concludes the round with no human involved** —
usually within ten minutes.

**You do not need to know Lean.** You solve the problem in whatever language you like, then paste
your answer into one line:

```lean
theorem golomb8 : ∃ m : List Nat, golomb8OK m = true := by
  exact ⟨[0, 1, 4, 9, 15, 22, 32, 34], by decide⟩
```

`by decide` asks Lean's kernel to evaluate the check. That is the whole proof. Setup is two minutes
and needs no Mathlib:

```bash
elan toolchain install leanprover/lean4:v4.33.0
lean Golomb8.lean          # about two seconds; silence means it is correct
```

Then paste the file into the submission box.

**If it is rejected**, Lean will tell you only that the predicate is false, not *why*. Each board
file's docstring carries a short `#eval` recipe — paste it at the end of the file and re-run, and it
prints which condition failed and the offending values. Or run the Python checker, which names the
failure directly.

### The JSON route — run the checker yourself

Every board has a `check.py` that takes your answer as JSON:

```bash
git clone https://github.com/math-market/practice-problems
cd practice-problems
python3 golomb8/check.py my-answer.json
```

| exit | meaning |
|---|---|
| `0` | valid |
| `1` | invalid — the answer is wrong, and the message says how |
| `2` | unreadable — your file is not in the stated format |
| `4` | the checker itself failed — never a verdict against you |

The `1` / `2` distinction is the one to watch: `2` means fix your JSON, `1` means fix your
mathematics.

**Be aware:** the platform cannot yet run these checkers itself, so a JSON submission waits for a
person to read it, and there is currently a backlog. If you want a fast verdict, use a Lean board.
We are fixing this; until then we would rather say so than have you wonder.

## The boards

| board | problem |
|---|---|
| `debruijn26` | De Bruijn sequence B(2,6) — 64 bits, every 6-bit word once |
| `debruijn33` | De Bruijn sequence B(3,3) |
| `mols4` | Three mutually orthogonal Latin squares of order 4 |
| `sts13` | Steiner triple system on 13 points |
| `hadamard12` | Hadamard matrix of order 12 |
| `costas12` | Costas array of order 12 |
| `golomb8` ★ | Optimal Golomb ruler of order 8 |
| `difference21` ★ | Planar difference set (21, 5, 1) |
| `egyptian121` ★ | 5/121 as three distinct unit fractions |
| `graceful7` ★ | Graceful labelling of a tree |

All ten have a Lean statement and settle automatically.

## Two things to try before you solve

**Predict the near-miss.** Every board ships an answer that is correct in every respect except one,
in `<board>/examples/near-miss-*.json` (or the file named `nearMiss` for that board in
`task.json`). Before you solve the board, run the checker on it and predict which condition fails
and why. The distinction between "looks right" and "is right" is the whole subject.

**Read the Lean statement as a specification.** `golomb8OK` in `lean/Golomb8.lean` says exactly what
"optimal Golomb ruler of order 8" means, with no prose ambiguity. Comparing it with the English
statement is a short lesson in what formalisation buys you.

## When you submit, say how you found it

The submission box is free text and it is required. Please use it: **which construction did you
use, and how large was the search?** Two lines is plenty —

> Welch construction, primitive root 2 mod 13.

> Branch-and-bound over mark positions, ~40k nodes after pruning on repeated distances.

The checker cannot tell whether a person or a model produced the answer, and we are not trying to
stop you using one. But an answer with no account of where it came from teaches you nothing and
tells us nothing, and these boards exist for both of those.

## How the boards connect

They are not ten unrelated puzzles.

- `mols4` and `difference21` are both the **projective plane of order 4**, written two ways.
- `sts13` and `difference21` are both **cyclic designs**: base blocks plus all translates.
- `hadamard12` and `costas12` both come from **residues modulo a prime** — squares mod 11 for
  Paley, a primitive root mod 13 for Welch.
- `debruijn26` and `debruijn33` are the **same construction over different alphabets**.

Each board's full statement is in [`tasks/`](tasks/), with the submission format and a worked
example of the *format* (not of the answer).

## Two things worth saying plainly

**These are not a contest.** A correct answer to every board is already in this repository — the
fixtures that prove each checker rejects near-misses necessarily contain one. Looking is not
cheating; it is a practice board. The point is to run the pipeline yourself and see a verdict come
back, not to be first.

**The bounties are small on purpose** — 100 credits. The interesting boards are elsewhere. When you
have cleared a few of these, the open frontier is the same shape with the answer removed: the
no-isosceles record, the magic squares, Hadamard order 668, the merit factor. Those are genuinely
unsolved, and a good undergraduate can contribute to them.

## If something goes wrong

Open an issue on this repository, or comment on the board. A checker that is wrong is our fault and
we want to know — one board on this platform was once winnable by a sequence published in 1953,
because its stated bound was off by one word.
