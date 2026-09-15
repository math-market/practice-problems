/-!
# Sidon set in [1,100]

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Sidon100.lean`:

    def S : List Nat := [your, increasing, set]
    #eval S.length >= 12
    #eval S.all (fun x => 1 <= x && x <= 100)
    #eval sortedN S                -- the checker wants them in increasing order
    #eval nodupN (diffs S)         -- all differences distinct?

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

/-- Every pairwise difference, for a strictly increasing list. -/
def diffs : List Nat → List Nat
  | [] => []
  | a :: t => t.map (· - a) ++ diffs t

/-- At least 12 increasing integers in [1,100] with all pairwise differences distinct. -/
def sidon100OK (S : List Nat) : Bool :=
  S.length >= 12 && S.all (fun x => 1 <= x && x <= 100) && sortedN S && nodupN (diffs S)

/-- The board. -/
theorem sidon100 : ∃ S : List Nat, sidon100OK S = true := by
  sorry
