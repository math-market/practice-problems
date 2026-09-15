/-!
# Kirkman's schoolgirl problem

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Kirkman15.lean`:

    def D : List (List (List Nat)) := [your, seven, days]
    #eval D.length == 7
    #eval D.map (fun day => (List.range 15).all (fun v => (day.flatMap id).count v == 1))
          -- one entry per day; false means that day is not a partition
    #eval ((D.flatMap id).flatMap pairsOf).eraseDups.length == 105

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- The three pairs inside a triple, encoded as `15*min + max`. -/
def pairsOf (t : List Nat) : List Nat :=
  (t.flatMap (fun a => t.map (fun b => if a < b then a * 15 + b else 0))).filter (· != 0)

/-- Seven days, each splitting the 15 girls into 5 triples, every pair together once. -/
def kirkman15OK (D : List (List (List Nat))) : Bool :=
  D.length == 7 &&
  D.all (fun day => day.length == 5 &&
     (List.range 15).all (fun v => (day.flatMap id).count v == 1)) &&
  (let ps := (D.flatMap id).flatMap pairsOf
   ps.length == 105 &&
   (List.range 15).all (fun a => (List.range 15).all (fun b =>
      if a < b then ps.count (a * 15 + b) == 1 else true)))

/-- The board. -/
theorem kirkman15 : ∃ D : List (List (List Nat)), kirkman15OK D = true := by
  sorry
