/-!
# Optimal Golomb ruler of order 8

A Golomb ruler is a set of integer marks on a line whose pairwise distances are all
distinct. Its length is the distance from the first mark to the last, and a ruler is
optimal for its order when no shorter one with that many marks exists. For eight marks
the optimal length is 34.

Replace `sorry` with your ruler. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨[your, eight, marks, here], by decide⟩

`decide` evaluates the predicate in Lean's kernel, so a wrong ruler does not merely fail
to prove the goal: the kernel proves the goal false and the build fails.

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- No repeated element. -/
def nodupN : List Nat → Bool
  | [] => true
  | a :: t => !t.contains a && nodupN t

/-- Strictly increasing. -/
def sortedN : List Nat → Bool
  | [] => true
  | [_] => true
  | a :: b :: t => a < b && sortedN (b :: t)

/-- Every pairwise distance, for a strictly increasing list. -/
def diffs : List Nat → List Nat
  | [] => []
  | a :: t => t.map (· - a) ++ diffs t

/-- Eight marks, strictly increasing, all 28 pairwise distances distinct, length exactly 34. -/
def golomb8OK (m : List Nat) : Bool :=
  m.length == 8 && sortedN m && nodupN (diffs m) && (m.getLast! - m.headD 0 == 34)

/-- There is an optimal Golomb ruler of order 8. -/
theorem golomb8 : ∃ m : List Nat, golomb8OK m = true := by
  sorry
