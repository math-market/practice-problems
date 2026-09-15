/-!
# Costas array of order 12

A permutation p of {1,…,12} — read as dots at (column i, row p[i]) — whose displacement
vectors between pairs of dots are all distinct. Equivalently, for every horizontal shift h
the differences p[i+h] − p[i] are pairwise distinct.

Welch's construction reaches order 12: take a primitive root g modulo the prime 13 and set
p[i] = gⁱ mod 13, which lands in 1..12 automatically. (The `hadamard12` board also comes
from residues modulo a prime — squares mod 11 there, a primitive root mod 13 here.)

Costas arrays give radar waveforms with an ideal ambiguity function: any shift in time and
frequency coincides with at most one other dot.

Replace `sorry` with your permutation. Everything above the proof is locked.

    exact ⟨[p₁, p₂, ..., p₁₂], by decide⟩

If rejected, append these lines and re-run `lean Costas12.lean`:

    def p : List Int := [your, twelve, values]
    #eval (List.range 12).all (fun v => p.count (Int.ofNat v + 1) == 1)   -- a permutation?
    #eval (List.range 11).map (fun h =>
            nodupI ((List.range (11 - h)).map (fun i => p.getD (i+h+1) 0 - p.getD i 0)))
          -- one entry per shift; the false ones are where two displacements coincide

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- No repeated element. -/
def nodupI : List Int → Bool
  | [] => true
  | a :: t => !t.contains a && nodupI t

/-- A permutation of 1..12 whose displacement differences are distinct at every shift. -/
def costas12OK (p : List Int) : Bool :=
  p.length == 12 && (List.range 12).all (fun v => p.count (Int.ofNat v + 1) == 1) &&
  (List.range 11).all (fun h =>
     nodupI ((List.range (11 - h)).map (fun i => p.getD (i + h + 1) 0 - p.getD i 0)))

/-- There is a Costas array of order 12. -/
theorem costas12 : ∃ p : List Int, costas12OK p = true := by
  sorry
