/-!
# Binary code (10, 40, 4)

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Code10.lean`:

    def C : List (List Nat) := [your, forty, codewords]
    #eval C.length == 40
    #eval C.all (fun w => w.length == 10 && w.all (fun x => x == 0 || x == 1))
    #eval (List.range 40).all (fun i => (List.range 40).all (fun j =>
            if i < j then ham (C.getD i []) (C.getD j []) >= 4 else true))

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Hamming distance between two words. -/
def ham (a b : List Nat) : Nat := ((a.zip b).map (fun p => if p.1 == p.2 then 0 else 1)).sum

/-- Forty distinct binary words of length ten, pairwise at distance at least four. -/
def code10OK (C : List (List Nat)) : Bool :=
  C.length == 40 && C.all (fun w => w.length == 10 && w.all (fun x => x == 0 || x == 1)) &&
  (List.range 40).all (fun i => (List.range 40).all (fun j =>
     if i < j then ham (C.getD i []) (C.getD j []) >= 4 else true))

/-- The board. -/
theorem code10 : ∃ C : List (List Nat), code10OK C = true := by
  sorry
