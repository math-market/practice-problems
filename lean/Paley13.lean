/-!
# Paley graph of order 13

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Paley13.lean`:

    def A : List (List Nat) := [your, thirteen, rows]
    #eval (List.range 13).map (fun i => (A.getD i []).sum)     -- every degree must be 6
    #eval (List.range 13).all (fun i => (List.range 13).all (fun j =>
            (A.getD i []).getD j 0 == (A.getD j []).getD i 0))  -- symmetric?
    #eval (List.range 13).all (fun i => (List.range 13).all (fun j =>
            if i < j then common A i j == (if (A.getD i []).getD j 0 == 1 then 2 else 3) else true))

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Number of common neighbours of `i` and `j`. -/
def common (A : List (List Nat)) (i j : Nat) : Nat :=
  ((List.range 13).map (fun k => (A.getD i []).getD k 0 * (A.getD j []).getD k 0)).sum

/-- A strongly regular graph with parameters (13, 6, 2, 3). -/
def paley13OK (A : List (List Nat)) : Bool :=
  A.length == 13 && A.all (fun r => r.length == 13 && r.all (fun x => x == 0 || x == 1)) &&
  (List.range 13).all (fun i => (A.getD i []).getD i 0 == 0) &&
  (List.range 13).all (fun i => (List.range 13).all (fun j =>
     (A.getD i []).getD j 0 == (A.getD j []).getD i 0)) &&
  (List.range 13).all (fun i => (A.getD i []).sum == 6) &&
  (List.range 13).all (fun i => (List.range 13).all (fun j =>
     if i < j then common A i j == (if (A.getD i []).getD j 0 == 1 then 2 else 3) else true))

/-- The board. -/
theorem paley13 : ∃ A : List (List Nat), paley13OK A = true := by
  sorry
