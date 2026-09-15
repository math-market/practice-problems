/-!
# No-three-in-line on a 10×10 grid

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean NoThree10.lean`:

    def P : List (List Int) := [your, twenty, points]
    #eval P.length == 20
    #eval P.all (fun p => p.length == 2 && p.all (fun x => 0 <= x && x < 10))
    #eval (List.range 20).all (fun i => (List.range 20).all (fun j => (List.range 20).all (fun k =>
            if i < j && j < k then !(col3 (P.getD i []) (P.getD j []) (P.getD k [])) else true)))

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Are the three points collinear? Exact integer cross-product, no division. -/
def col3 (a b c : List Int) : Bool :=
  (b.getD 0 0 - a.getD 0 0) * (c.getD 1 0 - a.getD 1 0) ==
  (c.getD 0 0 - a.getD 0 0) * (b.getD 1 0 - a.getD 1 0)

/-- 20 distinct grid points, no three collinear. -/
def nothree10OK (P : List (List Int)) : Bool :=
  P.length == 20 && P.all (fun p => p.length == 2 && p.all (fun x => 0 <= x && x < 10)) &&
  (List.range 20).all (fun i => (List.range 20).all (fun j =>
     if i < j then P.getD i [] != P.getD j [] else true)) &&
  (List.range 20).all (fun i => (List.range 20).all (fun j => (List.range 20).all (fun k =>
     if i < j && j < k then !(col3 (P.getD i []) (P.getD j []) (P.getD k [])) else true)))

/-- The board. -/
theorem nothree10 : ∃ P : List (List Int), nothree10OK P = true := by
  sorry
