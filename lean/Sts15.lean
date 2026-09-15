/-!
# Steiner triple system on 15 points

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Sts15.lean`:

    def T : List (List Nat) := [your, thirty, five, triples]
    #eval T.length == 35
    #eval T.all (fun t => t.length == 3 && t.all (· < 15))
    #eval (T.flatMap pairsOf).length == 105
    #eval (T.flatMap pairsOf).eraseDups.length == 105     -- all pairs distinct?

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- The three pairs inside a triple, encoded as `15*min + max`. -/
def pairsOf (t : List Nat) : List Nat :=
  (t.flatMap (fun a => t.map (fun b => if a < b then a * 15 + b else 0))).filter (· != 0)

/-- 35 triples on 15 points covering each of the 105 pairs exactly once. -/
def sts15OK (T : List (List Nat)) : Bool :=
  T.length == 35 && T.all (fun t => t.length == 3 && t.all (· < 15)) &&
  (let ps := T.flatMap pairsOf
   ps.length == 105 &&
   (List.range 15).all (fun a => (List.range 15).all (fun b =>
      if a < b then ps.count (a * 15 + b) == 1 else true)))

/-- The board. -/
theorem sts15 : ∃ T : List (List Nat), sts15OK T = true := by
  sorry
