/-!
# 5/121 as three distinct unit fractions

Write 5/121 as 1/a + 1/b + 1/c with a, b, c distinct positive integers.

The equation is checked in integers rather than rationals: clearing denominators,
1/a + 1/b + 1/c = 5/121 is exactly 121·(bc + ac + ab) = 5·abc.

Replace `sorry` with your denominators. Everything above the proof is the locked
statement and must not change — the platform compares it byte for byte with the
posted board.

    exact ⟨[a, b, c], by decide⟩

If your triple is rejected, `decide` says only that the predicate is false. To find out
which condition failed, append these lines and re-run `lean Egyptian121.lean`:

    def d : List Nat := [your, three, denominators]
    #eval d.all (· > 0)
    #eval 121 * (d[1]! * d[2]! + d[0]! * d[2]! + d[0]! * d[1]!)   -- these two
    #eval 5 * (d[0]! * d[1]! * d[2]!)                             -- must be equal

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Three distinct positive denominators with 1/a + 1/b + 1/c = 5/121, cleared. -/
def egyptian121OK (d : List Nat) : Bool :=
  d.length == 3 && d.all (· > 0) &&
  (let a := d.getD 0 1
   let b := d.getD 1 1
   let c := d.getD 2 1
   a != b && b != c && a != c &&
   121 * (b * c + a * c + a * b) == 5 * (a * b * c))

/-- 5/121 is a sum of three distinct unit fractions. -/
theorem egyptian121 : ∃ d : List Nat, egyptian121OK d = true := by
  sorry
