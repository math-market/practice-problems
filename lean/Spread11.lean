/-!
# Eleven points spread in a square

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Spread11.lean`:

    def P : List (List Int) := [your, eleven, points]
    #eval P.length == 11
    #eval P.all (fun p => p.length == 2 && p.all (fun v => 0 <= v && v <= 1000))
    #eval (List.range 11).all (fun i => (List.range 11).all (fun j =>
            if i < j then d2 (P.getD i []) (P.getD j []) >= 158272 else true))

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Squared Euclidean distance, exact. -/
def d2 (a b : List Int) : Int :=
  (a.getD 0 0 - b.getD 0 0) * (a.getD 0 0 - b.getD 0 0) +
  (a.getD 1 0 - b.getD 1 0) * (a.getD 1 0 - b.getD 1 0)

/-- Eleven grid points, pairwise squared distance at least 158272. -/
def spread11OK (P : List (List Int)) : Bool :=
  P.length == 11 && P.all (fun p => p.length == 2 && p.all (fun v => 0 <= v && v <= 1000)) &&
  (List.range 11).all (fun i => (List.range 11).all (fun j =>
     if i < j then d2 (P.getD i []) (P.getD j []) >= 158272 else true))

/-- The board. -/
theorem spread11 : ∃ P : List (List Int), spread11OK P = true := by
  sorry
