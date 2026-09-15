/-!
# Planar difference set (21, 5, 1)

Five residues mod 21 whose twenty nonzero differences hit every nonzero residue
exactly once. Singer's theorem supplies one: a planar difference set with parameters
(q²+q+1, q+1, 1) exists for every prime power q, and q = 4 gives (21, 5, 1).

Replace `sorry` with your set. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨[r₁, r₂, r₃, r₄, r₅], by decide⟩

If your set is rejected, `decide` says only that the predicate is false. To find out
which condition failed, append these lines and re-run `lean Difference21.lean`:

    def S : List Nat := [your, five, residues]
    #eval S.length == 5                    -- five residues?
    #eval S.all (· < 21)                   -- all in range?
    #eval (diffsMod21 S).length == 20      -- twenty differences (i.e. S distinct)?
    #eval (List.range 20).all (fun v => (diffsMod21 S).count (v + 1) == 1)
    #eval (diffsMod21 S).mergeSort (· ≤ ·) -- read off the repeat, and what is missing

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- The twenty nonzero differences, taken mod 21. -/
def diffsMod21 (S : List Nat) : List Nat :=
  S.flatMap (fun a => S.filterMap (fun b => if a == b then none else some ((a + 21 - b) % 21)))

/-- Five distinct residues mod 21 whose differences hit each of 1..20 exactly once. -/
def difference21OK (S : List Nat) : Bool :=
  S.length == 5 && S.all (· < 21) &&
  (let d := diffsMod21 S
   d.length == 20 && (List.range 20).all (fun v => d.count (v + 1) == 1))

/-- There is a planar difference set with parameters (21, 5, 1). -/
theorem difference21 : ∃ S : List Nat, difference21OK S = true := by
  sorry
