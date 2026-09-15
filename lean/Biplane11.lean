/-!
# Biplane (11,5,2)

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Biplane11.lean`:

    def S : List Nat := [your, five, residues]
    #eval S.length == 5 && S.all (· < 11)
    #eval (diffsMod11 S).length == 20                    -- 20 means the residues are distinct
    #eval (List.range 10).map (fun v => (diffsMod11 S).count (v+1))   -- every entry must be 2

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- The twenty nonzero differences, taken mod 11. -/
def diffsMod11 (S : List Nat) : List Nat :=
  S.flatMap (fun a => S.filterMap (fun b => if a == b then none else some ((a + 11 - b) % 11)))

/-- Five distinct residues mod 11 whose differences hit each of 1..10 exactly twice. -/
def biplane11OK (S : List Nat) : Bool :=
  S.length == 5 && S.all (· < 11) &&
  (let d := diffsMod11 S
   d.length == 20 && (List.range 10).all (fun v => d.count (v + 1) == 2))

/-- The board. -/
theorem biplane11 : ∃ S : List Nat, biplane11OK S = true := by
  sorry
