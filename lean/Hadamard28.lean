/-!
# Hadamard matrix of order 28

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Hadamard28.lean`:

    def M : List (List Int) := [your, twenty, eight, rows]
    #eval M.length == 28 && M.all (fun r => r.length == 28)
    #eval M.all (fun r => r.all (fun x => x == 1 || x == -1))
    #eval (List.range 28).map (fun j => dot (col M 0) (col M j))
          -- entry 0 should be 28, every other entry 0

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Column `j` of the matrix. -/
def col (M : List (List Int)) (j : Nat) : List Int := M.map (fun r => r.getD j 0)

/-- Inner product of two columns. -/
def dot (a b : List Int) : Int := (a.zip b).foldl (fun s p => s + p.1 * p.2) 0

/-- Entries ±1 and HᵀH = 28·I. -/
def hadamard28OK (M : List (List Int)) : Bool :=
  M.length == 28 && M.all (fun r => r.length == 28 && r.all (fun x => x == 1 || x == -1)) &&
  (List.range 28).all (fun i => (List.range 28).all (fun j =>
      dot (col M i) (col M j) == (if i == j then 28 else 0)))

/-- The board. -/
theorem hadamard28 : ∃ M : List (List Int), hadamard28OK M = true := by
  sorry
