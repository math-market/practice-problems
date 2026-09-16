/-!
# Costas array of order 19

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Costas19.lean`:

    def p : List Int := [your, nineteen, values]
    #eval (List.range 19).all (fun v => p.count (Int.ofNat v + 1) == 1)
    #eval (List.range 18).map (fun h =>
            nodupI ((List.range (18-h)).map (fun i => p.getD (i+h+1) 0 - p.getD i 0)))
          -- one entry per shift; false marks a collision

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- No repeated element. -/
def nodupI : List Int → Bool
  | [] => true
  | a :: t => !t.contains a && nodupI t

/-- A permutation of 1..19 whose displacement differences are distinct at every shift. -/
def costas19OK (p : List Int) : Bool :=
  p.length == 19 && (List.range 19).all (fun v => p.count (Int.ofNat v + 1) == 1) &&
  (List.range 18).all (fun h =>
     nodupI ((List.range (18 - h)).map (fun i => p.getD (i + h + 1) 0 - p.getD i 0)))

/-- The board. -/
theorem costas19 : ∃ p : List Int, costas19OK p = true := by
  sorry
