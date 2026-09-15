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

Four boards currently have a Lean statement: **golomb8**, **difference21**, **graceful7**,
**egyptian121**. On these the platform builds your file, replays it through Lean's kernel, audits
its axioms, and **concludes the round with no human involved**.

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

★ has a Lean statement and settles automatically.

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
