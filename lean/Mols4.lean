/-!
# Three mutually orthogonal Latin squares of order 4

A Latin square of order n is an n×n array whose every row and column is a permutation of
0..n−1. Two are *orthogonal* when overlaying them yields all n² ordered pairs exactly once.
Three is the maximum for order 4, and a full set of n−1 exists exactly when a projective
plane of order n does — order 4 has one. Index rows and columns by GF(4) and take
L_a(i,j) = a·i + j for each nonzero a.

The same projective plane of order 4 is what makes the `difference21` board possible;
the two are worth reading together.

Replace `sorry` with your three squares. Everything above the proof is locked.

    exact ⟨[[[...],...], [[...],...], [[...],...]], by decide⟩

If rejected, append these lines and re-run `lean Mols4.lean`:

    def S : List (List (List Nat)) := [your, three, squares]
    #eval S.length == 3
    #eval S.map isLatin                       -- each must be true
    #eval orth (S.getD 0 []) (S.getD 1 [])    -- and each pair orthogonal
    #eval orth (S.getD 0 []) (S.getD 2 [])
    #eval orth (S.getD 1 []) (S.getD 2 [])

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- A permutation of 0..3. -/
def isPerm4 (r : List Nat) : Bool := r.length == 4 && (List.range 4).all (fun v => r.count v == 1)

/-- Every row and every column is a permutation of 0..3. -/
def isLatin (S : List (List Nat)) : Bool :=
  S.length == 4 && S.all isPerm4 &&
  (List.range 4).all (fun c => isPerm4 (S.map (fun r => r.getD c 0)))

/-- Overlaying the two squares yields all 16 ordered pairs exactly once. -/
def orth (A B : List (List Nat)) : Bool :=
  let ps := (List.range 4).flatMap (fun r => (List.range 4).map (fun c =>
              (A.getD r []).getD c 0 * 4 + (B.getD r []).getD c 0))
  (List.range 16).all (fun v => ps.count v == 1)

/-- Three Latin squares of order 4, pairwise orthogonal. -/
def mols4OK (Ss : List (List (List Nat))) : Bool :=
  Ss.length == 3 && Ss.all isLatin &&
  orth (Ss.getD 0 []) (Ss.getD 1 []) && orth (Ss.getD 0 []) (Ss.getD 2 []) &&
  orth (Ss.getD 1 []) (Ss.getD 2 [])

/-- There are three mutually orthogonal Latin squares of order 4. -/
theorem mols4 : ∃ S : List (List (List Nat)), mols4OK S = true := by
  sorry
