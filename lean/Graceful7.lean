/-!
# Graceful labelling of a 7-vertex tree

Label the vertices of the tree below with 0..6, each once, so that the six edge labels
|f(u) − f(v)| are exactly 1, 2, 3, 4, 5, 6 — each occurring once.

The vertex numbers in `edges` are positions: `f[i]` is the label you give vertex i.

Replace `sorry` with your labelling. Everything above the proof is the locked statement
and must not change — the platform compares it byte for byte with the posted board.

    exact ⟨[l₀, l₁, l₂, l₃, l₄, l₅, l₆], by decide⟩

If your labelling is rejected, `decide` says only that the predicate is false. To find
out which condition failed, append these lines and re-run `lean Graceful7.lean`:

    def f : List Nat := [your, seven, labels]
    #eval (List.range 7).all (fun v => f.count v == 1)   -- a permutation of 0..6?
    #eval edgeLabels f                                   -- should be 1..6 in some order

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- The tree, as an edge list on vertices 0..6. -/
def edges : List (Nat × Nat) := [(0,1), (0,2), (0,3), (1,4), (1,5), (2,6)]

/-- The six induced edge labels |f u - f v|. -/
def edgeLabels (f : List Nat) : List Nat :=
  edges.map (fun e =>
    let a := f.getD e.1 0
    let b := f.getD e.2 0
    if a < b then b - a else a - b)

/-- A permutation of 0..6 whose six edge labels are exactly 1..6. -/
def graceful7OK (f : List Nat) : Bool :=
  f.length == 7 && (List.range 7).all (fun v => f.count v == 1) &&
  (List.range 6).all (fun v => (edgeLabels f).count (v + 1) == 1)

/-- The tree above has a graceful labelling. -/
theorem graceful7 : ∃ f : List Nat, graceful7OK f = true := by
  sorry
