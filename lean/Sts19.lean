/-!
# Steiner triple system on 19 points

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Sts19.lean`:

    def T : List (List Nat) := [your, fifty, seven, triples]
    #eval T.length == 57
    #eval T.all (fun t => t.length == 3 && t.all (· < 19) && t.eraseDups.length == 3)
    #eval (T.flatMap pairsOf).length == 171
    #eval (T.flatMap pairsOf).eraseDups.length == 171   -- all pairs distinct?

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

-- The pair list has 171 entries and `eraseDups` walks it recursively; the kernel's
-- default recursion budget is not enough. This is part of the locked statement.
set_option maxRecDepth 20000

/-- The three pairs inside a triple, encoded as `19*min + max`. -/
def pairsOf (t : List Nat) : List Nat :=
  (t.flatMap (fun a => t.map (fun b => if a < b then a * 19 + b else 0))).filter (· != 0)

/-- 57 triples on 19 points covering each of the 171 pairs exactly once. -/
def sts19OK (T : List (List Nat)) : Bool :=
  T.length == 57 && T.all (fun t => t.length == 3 && t.all (· < 19)) &&
  T.all (fun t => t.eraseDups.length == 3) &&
  (let ps := T.flatMap pairsOf
   ps.length == 171 && ps.eraseDups.length == 171)

/-- The board. -/
theorem sts19 : ∃ T : List (List Nat), sts19OK T = true := by
  sorry
