/-!
# Optimal Golomb ruler of order 13

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Golomb13.lean`:

    def m : List Nat := [your, thirteen, marks]
    #eval m.length == 13
    #eval sortedN m
    #eval nodupN (diffs m)                 -- all 78 distances distinct?
    #eval m.getLast! - m.headD 0           -- what is the length?

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

/-- Thirteen marks, increasing, all 78 distances distinct, length exactly 106. -/
def golomb13OK (m : List Nat) : Bool :=
  m.length == 13 && sortedN m && nodupN (diffs m) && (m.getLast! - m.headD 0 == 106)

/-- The board. -/
theorem golomb13 : ∃ m : List Nat, golomb13OK m = true := by
  sorry
