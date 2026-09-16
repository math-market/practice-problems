/-!
# Ramsey colouring of K17

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Ramsey17.lean`:

    def A : List (List Nat) := [your, seventeen, rows]
    #eval (List.range 17).all (fun i => (List.range 17).all (fun j => e A i j == e A j i))
    #eval (List.range 17).all (fun a => (List.range 17).all (fun b => (List.range 17).all (fun x =>
            (List.range 17).all (fun y =>
              if a < b && b < x && x < y then !(monoK4 A 1 a b x y) else true))))
    #eval (List.range 17).all (fun a => (List.range 17).all (fun b => (List.range 17).all (fun x =>
            (List.range 17).all (fun y =>
              if a < b && b < x && x < y then !(monoK4 A 0 a b x y) else true))))

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Colour of the edge between `i` and `j`. -/
def e (A : List (List Nat)) (i j : Nat) : Nat := (A.getD i []).getD j 0

/-- Are these four vertices monochromatic in colour `c`? -/
def monoK4 (A : List (List Nat)) (c a b x y : Nat) : Bool :=
  e A a b == c && e A a x == c && e A a y == c && e A b x == c && e A b y == c && e A x y == c

/-- A symmetric 2-colouring of K17 with no monochromatic K4 in either colour. -/
def ramsey17OK (A : List (List Nat)) : Bool :=
  A.length == 17 && A.all (fun r => r.length == 17 && r.all (fun x => x == 0 || x == 1)) &&
  (List.range 17).all (fun i => e A i i == 0) &&
  (List.range 17).all (fun i => (List.range 17).all (fun j => e A i j == e A j i)) &&
  (List.range 17).all (fun a => (List.range 17).all (fun b => (List.range 17).all (fun x =>
    (List.range 17).all (fun y =>
      if a < b && b < x && x < y then !(monoK4 A 1 a b x y) && !(monoK4 A 0 a b x y) else true))))

/-- The board. -/
theorem ramsey17 : ∃ A : List (List Nat), ramsey17OK A = true := by
  sorry
