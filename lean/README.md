# Lean statements

A parallel route for the same boards: instead of submitting an answer as JSON, submit a Lean proof.
The predicate in each file is the same one the Python checker implements.

Each board is one locked statement. You supply the witness:

```lean
theorem golomb8 : ∃ m : List Nat, golomb8OK m = true := by
  exact ⟨[0, 1, 4, 9, 15, 22, 32, 34], by decide⟩
```

Everything from the top of the file through `:= by` is locked and compared byte for byte against the
posted board. Only what follows it is yours.

`by decide` evaluates the predicate in Lean's kernel. A wrong answer does not merely fail to prove
the goal — the kernel proves the goal *false* and the build fails. `sorry` and `native_decide` are
both rejected by the platform's axiom audit.

No Mathlib is needed: these are core Lean. To check locally,

```bash
elan toolchain install leanprover/lean4:v4.33.0
lean Golomb8.lean
```

which takes a couple of seconds.
