/-!
# De Bruijn sequence B(3,3)

A cyclic sequence over {0,1,2} of length 27 in which each of the 27 three-symbol words
appears exactly once. Smaller than B(2,6), but the ternary alphabet breaks any
binary-specific shortcut; the Eulerian-circuit construction works unchanged.

Replace `sorry` with your sequence. Everything above the proof is the locked statement
and must not change.

    exact ⟨[s₀, s₁, ..., s₂₆], by decide⟩

If it is rejected, append these lines and re-run `lean DeBruijn33.lean`:

    def s : List Nat := [your, twenty, seven, symbols]
    #eval s.length == 27
    #eval s.all (· < 3)
    #eval ((List.range 27).map (win3 s.toArray)).eraseDups.length   -- want 27

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- No repeated element. -/
def nodupN : List Nat → Bool
  | [] => true
  | a :: t => !t.contains a && nodupN t

/-- The 3-symbol word starting at position `i`, read cyclically, as a base-3 number. -/
def win3 (s : Array Nat) (i : Nat) : Nat :=
  (List.range 3).foldl (fun acc k => acc * 3 + s[(i + k) % 27]!) 0

/-- 27 ternary symbols whose 27 cyclic 3-windows are all distinct. -/
def debruijn33OK (l : List Nat) : Bool :=
  l.length == 27 && l.all (· < 3) && nodupN ((List.range 27).map (win3 l.toArray))

/-- A de Bruijn sequence B(3,3) exists. -/
theorem debruijn33 : ∃ s : List Nat, debruijn33OK s = true := by
  sorry
