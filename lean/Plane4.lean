/-!
# Projective plane of order 4

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Plane4.lean`:

    def L : List (List Nat) := [your, twenty, one, lines]
    #eval L.length == 21
    #eval L.all (fun l => l.length == 5 && l.all (· < 21))
    #eval (L.flatMap pairsOf5).length == 210          -- 21 lines x 10 pairs
    #eval (L.flatMap pairsOf5).eraseDups.length == 210 -- all distinct = every pair once

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

-- The pair list has 210 entries and `eraseDups` walks it recursively; the kernel's
-- default recursion budget is not enough. This is part of the locked statement.
set_option maxRecDepth 20000

/-- The ten pairs inside a line, encoded as `21*min + max`. -/
def pairsOf5 (l : List Nat) : List Nat :=
  (l.flatMap (fun a => l.map (fun b => if a < b then a * 21 + b else 0))).filter (· != 0)

/-- 21 lines of 5 points on 21 points, every pair on exactly one line.

There are exactly C(21,2) = 210 pairs of points, and 21 lines of 5 points supply 210 pairs
in total. So "all 210 are distinct" is the same condition as "every pair exactly once",
and it is far cheaper for the kernel to evaluate than 441 separate counts. -/
def plane4OK (L : List (List Nat)) : Bool :=
  L.length == 21 && L.all (fun l => l.length == 5 && l.all (· < 21)) &&
  L.all (fun l => l.eraseDups.length == 5) &&
  (let ps := L.flatMap pairsOf5
   ps.length == 210 && ps.eraseDups.length == 210)

/-- The board. -/
theorem plane4 : ∃ L : List (List Nat), plane4OK L = true := by
  sorry
