# practice-problems — criteria repository

Checkers and fixtures for the **Practice problems** boards on
[problem.market](https://problem.market). Ten classical combinatorial constructions, each decided
by a script of a few dozen lines, each with a known answer.

They are here to be *finished*. Most open boards on the platform are research problems where nobody
has succeeded; these are problems where a good evening's work produces a verdict. When you have
cleared a few, the frontier boards — no-isosceles, the magic squares, the merit factor, Hadamard
order 668 — are the same shape with the answer removed.

## The boards

| Board | Problem | Task |
|---|---|---|
| `debruijn26` | De Bruijn sequence B(2,6) | [tasks/debruijn26.md](tasks/debruijn26.md) |
| `debruijn33` | De Bruijn sequence B(3,3) | [tasks/debruijn33.md](tasks/debruijn33.md) |
| `mols4` | Three MOLS of order 4 | [tasks/mols4.md](tasks/mols4.md) |
| `sts13` | Steiner triple system on 13 points | [tasks/sts13.md](tasks/sts13.md) |
| `hadamard12` | Hadamard matrix of order 12 | [tasks/hadamard12.md](tasks/hadamard12.md) |
| `costas12` | Costas array of order 12 | [tasks/costas12.md](tasks/costas12.md) |
| `golomb8` | Optimal Golomb ruler of order 8 | [tasks/golomb8.md](tasks/golomb8.md) |
| `difference21` | Planar difference set (21,5,1) | [tasks/difference21.md](tasks/difference21.md) |
| `egyptian121` | 5/121 as three unit fractions | [tasks/egyptian121.md](tasks/egyptian121.md) |
| `graceful7` | Graceful labelling of a tree | [tasks/graceful7.md](tasks/graceful7.md) |

`boards.tsv` maps each board to its directory and bounty.

## Running a checker

```bash
python3 golomb8/check.py my-answer.json    # your submission
./verify.sh golomb8                        # that board's fixtures
./verify.sh                                # all ten, exactly as CI runs them
```

## Exit codes

Every checker follows the same contract:

| Code | Meaning | Settles? |
|---|---|---|
| `0` | valid | yes |
| `1` | invalid — the answer is wrong, and the message says how | yes |
| `2` | unreadable — the file is not in the stated format | no |
| `4` | the checker itself failed | **never** |

The distinction between `1` and `2` is the one that matters to you: `2` means fix your JSON, `1`
means fix your mathematics. Exit `4` is never a verdict against a submission.

## Fixtures

Each board ships fixtures in `examples/` with expected exit codes in `examples/expected.json`, and
`verify.sh` asserts that every checker both **accepts** something and **rejects** something. A
checker that only ever rejects passes every rejection fixture and is useless.

Where a board states a bound, it also ships a **near-miss** — an answer that is correct in every
respect except the bound. `golomb8` carries `[0, 1, 8, 20, 22, 25, 31, 35]` — a genuine 8-mark
Golomb ruler, every distance distinct, rejected *only* because its length is 35 and the optimum is
34. A near-miss that fails for some other reason tests nothing; that is the trap this repository
exists to avoid.

## Pinning

Boards pin a specific commit of this repository. A criterion that could move is not a criterion.
`harness-guard` rejects pull requests that touch a checker, its fixtures, or the runner.

Apache-2.0.
