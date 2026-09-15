/-!
# A cubic graph of girth 5 on 10 vertices

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Petersen.lean`:

    def E : List (List Nat) := [your, fifteen, edges]
    #eval E.length == 15
    #eval (List.range 10).map (deg E)      -- every degree must be 3
    #eval (List.range 10).all (fun a => (List.range 10).all (fun b =>
            if a < b then ((List.range 10).filter (fun x => isEdge E a x && isEdge E b x)).length <= 1
            else true))                    -- false means a 4-cycle

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Degree of a vertex in the edge list. -/
def deg (E : List (List Nat)) (v : Nat) : Nat :=
  (E.filter (fun e => e.getD 0 0 == v || e.getD 1 0 == v)).length

/-- Is `[a,b]` an edge? -/
def isEdge (E : List (List Nat)) (a b : Nat) : Bool :=
  E.any (fun e => (e.getD 0 0 == a && e.getD 1 0 == b) || (e.getD 0 0 == b && e.getD 1 0 == a))

/-- Cubic, simple, on 10 vertices, with no cycle of length 3 or 4. -/
def petersenOK (E : List (List Nat)) : Bool :=
  E.length == 15 && E.all (fun e => e.length == 2 && e.all (· < 10)) &&
  E.all (fun e => e.getD 0 0 != e.getD 1 0) &&
  (List.range 10).all (fun v => deg E v == 3) &&
  -- no triangle
  (List.range 10).all (fun a => (List.range 10).all (fun b => (List.range 10).all (fun c =>
     if a < b && b < c then !(isEdge E a b && isEdge E b c && isEdge E a c) else true))) &&
  -- no 4-cycle: two distinct vertices with two common neighbours
  (List.range 10).all (fun a => (List.range 10).all (fun b =>
     if a < b then ((List.range 10).filter (fun x => isEdge E a x && isEdge E b x)).length <= 1
     else true))

/-- The board. -/
theorem petersen : ∃ E : List (List Nat), petersenOK E = true := by
  sorry
