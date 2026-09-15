/-!
# Costas array of order 17

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Costas17.lean`:

    def p : List Int := [your, seventeen, values]
    #eval (List.range 17).all (fun v => p.count (Int.ofNat v + 1) == 1)
    #eval (List.range 16).map (fun h =>
            nodupI ((List.range (16-h)).map (fun i => p.getD (i+h+1) 0 - p.getD i 0)))
          -- one entry per shift; false marks a collision

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- No repeated element. -/
def nodupI : List Int → Bool
  | [] => true
  | a :: t => !t.contains a && nodupI t

/-- A permutation of 1..17 whose displacement differences are distinct at every shift. -/
def costas17OK (p : List Int) : Bool :=
  p.length == 17 && (List.range 17).all (fun v => p.count (Int.ofNat v + 1) == 1) &&
  (List.range 16).all (fun h =>
     nodupI ((List.range (16 - h)).map (fun i => p.getD (i + h + 1) 0 - p.getD i 0)))

/-- The board. -/
theorem costas17 : ∃ p : List Int, costas17OK p = true := by
  sorry
