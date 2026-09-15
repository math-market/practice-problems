/-!
# Optimal Golomb ruler of order 11

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Golomb11.lean`:

    def m : List Nat := [your, eleven, marks]
    #eval m.length == 11
    #eval sortedN m
    #eval nodupN (diffs m)                 -- all 55 distances distinct?
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

/-- Eleven marks, strictly increasing, all 55 distances distinct, length exactly 72. -/
def golomb11OK (m : List Nat) : Bool :=
  m.length == 11 && sortedN m && nodupN (diffs m) && (m.getLast! - m.headD 0 == 72)

/-- The board. -/
theorem golomb11 : ∃ m : List Nat, golomb11OK m = true := by
  sorry
