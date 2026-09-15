/-!
# Hadamard matrix of order 12

A matrix with entries ±1 whose columns are mutually orthogonal, so HᵀH = 12·I. It attains
the largest possible determinant for a matrix bounded by 1 in absolute value.

Paley's 1933 construction applies: q = 11 is a prime ≡ 3 (mod 4), so build the 11×11
Jacobsthal matrix from the quadratic-residue character mod 11, border it, and fix signs.
The `costas12` board also comes from residues modulo a prime — Paley uses squares mod 11,
Welch uses a primitive root mod 13.

Replace `sorry` with your matrix. Everything above the proof is locked.

    exact ⟨[[1, 1, ...], [1, -1, ...], ...], by decide⟩

If rejected, append these lines and re-run `lean Hadamard12.lean`:

    def M : List (List Int) := [your, twelve, rows]
    #eval M.length == 12 && M.all (fun r => r.length == 12)
    #eval M.all (fun r => r.all (fun x => x == 1 || x == -1))
    #eval (List.range 12).map (fun j => dot (col M 0) (col M j))
          -- entry 0 should be 12, every other entry 0

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Column `j` of the matrix. -/
def col (M : List (List Int)) (j : Nat) : List Int := M.map (fun r => r.getD j 0)

/-- Inner product of two columns. -/
def dot (a b : List Int) : Int := (a.zip b).foldl (fun s p => s + p.1 * p.2) 0

/-- Entries ±1 and every pair of columns orthogonal, each column of norm² 12. -/
def hadamard12OK (M : List (List Int)) : Bool :=
  M.length == 12 && M.all (fun r => r.length == 12 && r.all (fun x => x == 1 || x == -1)) &&
  (List.range 12).all (fun i => (List.range 12).all (fun j =>
      dot (col M i) (col M j) == (if i == j then 12 else 0)))

/-- There is a Hadamard matrix of order 12. -/
theorem hadamard12 : ∃ M : List (List Int), hadamard12OK M = true := by
  sorry
