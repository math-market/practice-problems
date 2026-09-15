/-!
# Steiner triple system on 13 points

A collection of 3-element subsets of {0,…,12} — *triples* — such that every unordered pair
of points lies in exactly one triple. Counting pairs forces exactly 13·12/6 = 26 triples.

Kirkman proved in 1847 that an STS(v) exists precisely when v ≡ 1 or 3 (mod 6). The quick
route is cyclic: find base triples whose differences cover every nonzero residue mod 13,
then take all 13 translates — the same cyclic-design idea behind the `difference21` board.

Replace `sorry` with your triples. Everything above the proof is locked.

    exact ⟨[[0,1,4], [0,2,7], ...], by decide⟩

If rejected, append these lines and re-run `lean Sts13.lean`:

    def T : List (List Nat) := [your, twenty, six, triples]
    #eval T.length == 26
    #eval T.all (fun t => t.length == 3 && t.all (· < 13))
    #eval (T.flatMap pairsOf).length == 78                  -- 26 triples x 3 pairs
    #eval (T.flatMap pairsOf).eraseDups.length == 78        -- all pairs distinct?

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- The three pairs inside a triple, each encoded as `13*min + max`. -/
def pairsOf (t : List Nat) : List Nat :=
  (t.flatMap (fun a => t.map (fun b => if a < b then a * 13 + b else 0))).filter (· != 0)

/-- 26 triples on 13 points covering each of the 78 pairs exactly once. -/
def sts13OK (T : List (List Nat)) : Bool :=
  T.length == 26 && T.all (fun t => t.length == 3 && t.all (· < 13)) &&
  (let ps := T.flatMap pairsOf
   ps.length == 78 &&
   (List.range 13).all (fun a => (List.range 13).all (fun b =>
      if a < b then ps.count (a * 13 + b) == 1 else true)))

/-- There is a Steiner triple system on 13 points. -/
theorem sts13 : ∃ T : List (List Nat), sts13OK T = true := by
  sorry
