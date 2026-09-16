/-!
# Heilbronn configuration, n = 7

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Heilbronn7.lean`:

    def P : List (List Int) := [your, seven, points]
    #eval P.length == 7
    #eval P.all (fun p => p.length == 2 && p.all (fun v => 0 <= v && v <= 1000))
    #eval (List.range 7).all (fun i => (List.range 7).all (fun j => (List.range 7).all (fun k =>
            if i < j && j < k then iabs (cross (P.getD i []) (P.getD j []) (P.getD k [])) >= 167268
            else true)))

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- Twice the signed area of the triangle, as an exact integer. -/
def cross (a b c : List Int) : Int :=
  (b.getD 0 0 - a.getD 0 0) * (c.getD 1 0 - a.getD 1 0) -
  (c.getD 0 0 - a.getD 0 0) * (b.getD 1 0 - a.getD 1 0)

/-- |x| for integers. -/
def iabs (x : Int) : Int := if x < 0 then -x else x

/-- Seven grid points, every triangle with 2·area·1000² at least 167268. -/
def heilbronn7OK (P : List (List Int)) : Bool :=
  P.length == 7 && P.all (fun p => p.length == 2 && p.all (fun v => 0 <= v && v <= 1000)) &&
  (List.range 7).all (fun i => (List.range 7).all (fun j =>
     if i < j then P.getD i [] != P.getD j [] else true)) &&
  (List.range 7).all (fun i => (List.range 7).all (fun j => (List.range 7).all (fun k =>
     if i < j && j < k then iabs (cross (P.getD i []) (P.getD j []) (P.getD k [])) >= 167268
     else true)))

/-- The board. -/
theorem heilbronn7 : ∃ P : List (List Int), heilbronn7OK P = true := by
  sorry
