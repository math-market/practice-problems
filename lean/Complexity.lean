/-!
# Integer complexity

Replace `sorry` with your answer. Everything above the proof is the locked statement and
must not change — the platform compares it byte for byte with the posted board.

    exact ⟨your_answer, by decide⟩

If it is rejected, `decide` says only that the predicate is false. To find out which
condition failed, append these lines and re-run `lean Complexity.lean`:

    def e : Expr := your_expression
    #eval ev e        -- must be 10206
    #eval ones e      -- must be at most 26

Toolchain: leanprover/lean4:v4.33.0
Mathlib: db584cd6d46c92f209a44c0f1c829460d327499d
-/

/-- An arithmetic expression built from 1 with + and *. -/
inductive Expr where
  | one : Expr
  | add : Expr → Expr → Expr
  | mul : Expr → Expr → Expr
deriving DecidableEq

/-- The value of the expression. -/
def ev : Expr → Nat
  | .one => 1
  | .add a b => ev a + ev b
  | .mul a b => ev a * ev b

/-- How many ones it uses. -/
def ones : Expr → Nat
  | .one => 1
  | .add a b => ones a + ones b
  | .mul a b => ones a + ones b

/-- An expression for 10206 using at most 26 ones. -/
def complexityOK (e : Expr) : Bool := ev e == 10206 && ones e <= 26

/-- The board. -/
theorem complexity : ∃ e : Expr, complexityOK e = true := by
  sorry
