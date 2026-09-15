# Adding a board

This repository holds the deterministic **practice boards** on
[problem.market](https://problem.market). A *board* is one problem: a checker that decides it, the
fixtures that prove the checker works, and the text a solver reads. Adding one is six files and a
row, and this document is the whole procedure.

Two rules stand above the rest, because each of them is a mistake we have already made:

> **Never publish a board you have not solved yourself.** Write the generator, produce a real
> answer, and only then write the checker. A board nobody has solved may be impossible, and you
> will not find out until a solver has spent their evening on it.

> **A rejection fixture must fail for the *right* reason.** A fixture that fails for some other
> reason tests nothing, and in CI it looks exactly like one that works. See *Near-misses* below;
> this is the single most important thing on the page.

---

## The procedure

### 1. Scaffold

```bash
./new-board.sh mynewboard
```

This creates `mynewboard/check.py` (a skeleton with the exit contract already wired),
`mynewboard/examples/`, and `tasks/mynewboard.md`, and prints the remaining steps.

### 2. Solve it first

Write a generator — anywhere, it is not committed — and produce a genuine answer. This is what
proves the board is winnable. Keep the answer; it becomes `examples/valid.json`.

If you cannot solve it, the board does not belong in this repository. Practice boards are problems
with known answers; the open frontier lives on other boards.

### 3. Write the checker

`mynewboard/check.py` reads one JSON file named on the command line and exits:

| code | meaning | settles? |
|---|---|---|
| `0` | valid | yes |
| `1` | invalid — the answer is wrong | yes |
| `2` | unreadable — the file is not in the stated format | no |
| `4` | the checker itself failed | **never** |

The distinction between `1` and `2` is what a solver needs: `2` means fix your JSON, `1` means fix
your mathematics. Never return `1` for a malformed file — you are telling someone their
mathematics is wrong when their bracket is missing.

**Validate shape before you validate content.** If a submission's entries are the wrong type, that
is `2`, and it must be decided *before* any count or bound check — otherwise a malformed file gets
rejected as a wrong answer. (This exact bug shipped in `sts13` and was caught by a fixture.)

Use exact integer or `fractions.Fraction` arithmetic. No floating point: a board decided by a
rounding error is not deterministic.

Say *why* in every rejection. `"pair [1, 7] appears in more than one triple"` teaches; `"invalid"`
does not.

### 4. Write fixtures that discriminate

In `mynewboard/examples/`, with expected exit codes in `examples/expected.json`:

- **`valid.json`** — the answer you generated in step 2. At least one fixture must be accepted, or
  the accept path is unreachable and nobody can ever win.
- **at least one rejection** — or the checker cannot discriminate, and a checker that rejects
  everything passes every rejection test while being useless.
- **a malformed fixture** expecting `2`.
- **a near-miss** — see below.

### 5. Near-misses — the part that matters

**A near-miss is a submission correct in every respect except the one the board turns on.**

`golomb8` is the worked example. The board asks for an *optimal* 8-mark Golomb ruler: all 28
pairwise distances distinct, total length exactly 34. Its near-miss is
`[0, 1, 8, 20, 22, 25, 31, 35]` — a genuine Golomb ruler, every distance distinct, rejected *only*
because its length is 35. That fixture proves the optimality bound is load-bearing.

The first near-miss written for that board was `[0, 1, 4, 9, 15, 22, 32, 35]`, which is not a
Golomb ruler at all — two distances coincide. It was rejected on distinctness, the length bound was
never exercised, and **the fixture passed CI while testing nothing.**

This is not hypothetical. A board on this platform stated "length at least 13" where the source
said "greater than 13", and was therefore winnable by a sequence published in 1953. A near-miss
fixture would have caught it before anyone submitted.

Declare yours in `task.json`:

```json
{"board": "mynewboard", "nearMiss": "near-miss-one-repeated-difference.json", ...}
```

`lint.sh` runs it and requires exit `1`. **If no near-miss can exist, say so and why:**

```json
{"board": "egyptian121", "nearMiss": "sums-to-wrong-value.json",
 "nearMissWaiver": "The distinctness clause excludes nothing for this target: exhaustive
   search over both repetition patterns finds no triple with a repeated denominator summing
   to 5/121 at all."}
```

"No near-miss exists" and "nobody wrote one" look identical to a machine. The waiver is how you
tell them apart, and writing it forces you to find out which one is true.

### 6. Register it

- **`boards.tsv`** — one row: `board`, `directory`, `bounty`, `criterionKind`, `task-uuid`.
- **`task.json`** — an entry in `tasks[]` with `board`, `checker`, `statement`, `title`, and
  `nearMiss`. This manifest is what the platform reads at the pinned commit.
- **`README.md`** — a row in the board table.

### 7. Write the board text

`tasks/mynewboard.md`: what the problem is and why it is interesting; the submission format **with
a worked example**; how to run the checker; and what is still open in that area. Most solver
failures will be format errors, so the format section earns its place.

Write for someone who has not seen the problem before. Define the terms.

### 8. Check

```bash
./lint.sh              # every board complete and registered
./verify.sh mynewboard # that board's fixtures
./verify.sh            # all of them, exactly as CI runs them
```

Both must pass. CI runs `lint.sh` then `verify.sh` on every push and pull request.

### 9. Post the board

Boards pin a **commit**, not a branch — a criterion that could move is not a criterion. So merge
first, then post against the merged SHA, and put the task id back into `boards.tsv`.

The task description must link the checker and the statement at the full 40-character SHA:

```
https://github.com/math-market/practice-problems/blob/<SHA>/mynewboard/check.py
https://github.com/math-market/practice-problems/blob/<SHA>/tasks/mynewboard.md
```

The platform's `environment` publish check requires `verify.sh` **and `task.json`** at the root of
the pinned commit, and will flag the board if either is missing.

Before posting, **clone the repository fresh at that commit and run the commands your description
tells solvers to run.** If they do not work from a clean clone, they do not work.

---

## What the harness guarantees

`verify.sh` proves each checker **works**: every fixture gets its expected exit code, and each
board both accepts something and rejects something.

`lint.sh` proves each board is **complete**: directory, checker, fixtures, expectations, board
text, README row, `task.json` entry, and a near-miss that is genuinely rejected. A board is easy to
half-add, and a half-added board looks fine until a solver hits it.

`harness-guard` rejects pull requests that touch a checker, its fixtures, or the runner — the
machinery that judges a submission must not be editable by the submission.

## Conventions

- **Apache-2.0**, like every `math-market` criteria repository.
- **Python 3.12, standard library only.** No dependencies: the sandbox has no network, and a board
  that needs a package is a board that stops working when the package moves.
- **Bounties**: 100 credits for an evening's board, 250 for a weekend's, 500 for genuinely hard.
  The point is the record, not the money.
- **One repository, many boards.** Adding board thirty-one is a file and a row, not a new repo.
