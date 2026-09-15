/-!
# De Bruijn sequence B(2,6)

A cyclic binary sequence of length 64 in which every one of the 64 six-bit words appears
exactly once as a contiguous cyclic substring. Note *cyclic*: the window starting at
position 62 wraps round to positions 0 and 1.

Replace `sorry` with your sequence. Everything above the proof is the locked statement
and must not change — the platform compares it byte for byte with the posted board.

    exact ⟨[b₀, b₁, ..., b₆₃], by decide⟩

If your sequence is rejected, `decide` says only that the predicate is false. To find out
which condition failed, append these lines and re-run `lean DeBruijn26.lean`:

    def s : List Nat := [your, sixty, four, bits]
    #eval s.length == 64
    #eval s.all (fun b => b == 0 || b == 1)
    #eval ((List.range 64).map (win s.toArray)).length -
          ((List.range 64).map (win s.toArray)).eraseDups.length   -- repeats; want 0

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- No repeated element. -/
def nodupN : List Nat → Bool
  | [] => true
  | a :: t => !t.contains a && nodupN t

/-- The 6-bit word starting at position `i`, read cyclically, as a number. -/
def win (s : Array Nat) (i : Nat) : Nat :=
  (List.range 6).foldl (fun acc k => acc * 2 + s[(i + k) % 64]!) 0

/-- 64 bits whose 64 cyclic 6-windows are all distinct. -/
def debruijn26OK (l : List Nat) : Bool :=
  l.length == 64 && l.all (fun b => b == 0 || b == 1) &&
  nodupN ((List.range 64).map (win l.toArray))

/-- A de Bruijn sequence B(2,6) exists. -/
theorem debruijn26 : ∃ s : List Nat, debruijn26OK s = true := by
  sorry
