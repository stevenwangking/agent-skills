---
name: simplify
description: Simplify and refine recently modified code for clarity, consistency, reuse, and maintainability without changing behavior. Reviews changes through three lenses — reuse, quality, and efficiency. Use whenever the user asks to simplify, clean up, refine, polish, tidy, or reduce complexity in code; after a feature or bug fix leaves code working but harder to read; when changed code feels too nested, repetitive, overly clever, or inconsistent with project style; or after tests pass and before committing.
---

# Simplify

Reduce complexity while preserving exact behavior. The goal is not fewer lines — it's code that is easier to read, understand, modify, and debug. The test for every change: **would a new team member understand this faster than the original?**

## When to Use

- After a feature is working and tests pass, but the implementation feels heavier than it needs to be
- Code works but is harder to read, maintain, or extend than it should be
- Changed code shows deep nesting, duplication, unclear names, or dense one-liners
- Before committing or creating a PR, as a final polish step

## When NOT to Use

- Tests are failing because of the code being simplified — fix or confirm the baseline first. Pre-existing failures elsewhere in the suite are not a blocker; just distinguish baseline failures from any you introduce
- You don't yet understand what the code does — comprehend before you simplify
- The code is already clean and readable — don't simplify for the sake of it
- The code is performance-critical and the "simpler" version would be measurably slower
- The module is about to be rewritten entirely

## Workflow

### 1. Scope to What Changed

Default to the files and hunks modified in the current task or session:

- If git is available, derive the scope from the current diff instead of guessing
- If the user names a file, function, or directory, use exactly that
- No drive-by cleanup of unrelated code — unscoped simplification creates noisy diffs and regression risk. The one sanctioned widening: if making the simplification correct requires touching a helper or its direct callers just outside the diff, that is in scope — follow the call chain only as far as the change requires, and mention it in the summary. Anything broader needs an explicit ask

### 2. Understand Before Touching (Chesterton's Fence)

Before changing or removing anything, understand why it exists: if you see a fence across a road and don't know why it's there, don't tear it down. Answer first:

- What is this code's responsibility? What calls it, and what does it call?
- What are the edge cases and error paths? Which tests define the expected behavior?
- Why might it have been written this way — performance, platform constraint, history? Check git blame when useful

If you can't answer these, you're not ready to simplify. Read more context first.

### 3. Read Project Conventions

Simplification means making code more consistent with the codebase, not imposing external preferences:

- Read AGENTS.md / CLAUDE.md and follow its code standards
- Study how neighboring code handles similar patterns — imports, naming, error handling, type annotation depth
- Check lint/formatter config; the result must not introduce style regressions

Simplification that breaks project consistency is not simplification — it's churn.

### 4. Review Through Three Lenses

Scan the changed code through each lens:

- **Reuse** — prefer existing helpers, utilities, and local patterns before adding new ones. Do not abstract merely to eliminate duplication: extract a shared abstraction only when the behavior is genuinely the same, the concept has a clear name, readability improves, and the callers are likely to evolve together. Prefer a little duplication over a misleading abstraction.
- **Quality** — improve readability, naming, branching, cohesion, and type clarity; preserve logging, validation, and error semantics.
- **Efficiency** — remove unnecessary work in the touched code (redundant passes, allocations, awaits, lookups) only when the improvement is obvious and behavior stays identical. This is a restraint check, not a license for speculative optimization.

If the lenses conflict, prefer behavioral safety and readability over extra DRYing or micro-optimizations.

Scan for these signals. Each one prompts investigation and judgment — never refactoring solely because a threshold was crossed (deeply nested `if` blocks and a `?.` access chain are different problems; the numbers below are hints, not triggers):

| Category | Pattern | Simplification |
|----------|---------|----------------|
| Structure | Deep nesting (3+ levels) | Guard clauses or helper functions |
| Structure | Long functions (50+ lines) | Split into focused, descriptively named functions |
| Structure | Nested ternaries | if/else chains, switch, or lookup objects |
| Structure | Boolean flag parameters (`doThing(true, false)`) | Options object or separate functions |
| Naming | Generic names (`data`, `temp`, `res`, `val`) | Rename to describe content (`validationErrors`) |
| Naming | Abbreviations (`usr`, `cfg`, `evt`) | Full words, unless universal (`id`, `url`, `api`) |
| Naming | Misleading names (a `get` that mutates) | Rename to reflect actual behavior |
| Redundancy | Same 5+ lines in multiple places | Extract a shared function — only if the concept is genuinely shared, not just the text |
| Redundancy | Dead code, unused imports/vars, commented-out blocks | Remove after confirming truly dead |
| Redundancy | Wrapper adding no value; factory-for-a-factory | Inline it; use the direct approach |
| Redundancy | Redundant type assertions or `await` | Remove the assertion; drop the `await` only when error and ordering semantics stay identical |
| Comments | "What" comments on obvious code | Delete |
| Comments | "Why" comments carrying intent | Keep — they express what code cannot |

### 5. Simplify with Restraint

Keep changes small, coherent, and independently reviewable — the point is avoiding one giant mixed diff, not making one edit per turn. Prefer:

- Flattened nesting, early returns, guard clauses
- Clear names and direct data flow
- Small cohesive helpers over merged concerns
- Explicit control flow over dense one-liners

Common TypeScript simplifications:

```typescript
// Redundant boolean return
// Before
if (isValid(input)) {
  return true;
}
return false;
// After
return isValid(input);

// Nested ternary chain → explicit control flow
// Before
const label = item.isNew ? 'New' : item.isUpdated ? 'Updated' : item.isArchived ? 'Archived' : 'Active';
// After
function getStatusLabel(item: Item): string {
  if (item.isNew) return 'New';
  if (item.isUpdated) return 'Updated';
  if (item.isArchived) return 'Archived';
  return 'Active';
}
```

Language cautions — the "shorter" form often changes semantics. Do not swap between `||`, `??`, truthiness checks, and optional chaining, or replace `if` statements with logical expressions, without confirming the edges behave identically: falsy values (`''`, `0`, `false`, `NaN`), empty collections, thrown errors, and async ordering. Do not rewrite multi-step loops as `map`/`filter`/`reduce` chains when the chain is harder to follow or debug than the loop — comprehension beats functional style. For Vue code, additionally preserve reactivity, computed/watch dependency tracking, lifecycle timing, `v-model` behavior, and emitted events — these are user-visible contracts, not implementation details.

Watch the over-simplification traps:

- Inlining too aggressively — removing a helper that gave a concept its name makes the call site harder to read
- Combining unrelated logic — two simple functions merged into one complex function is not simpler
- Removing "unnecessary" abstractions that actually exist for extensibility or testability
- Optimizing for line count — fewer lines is not the goal; comprehension speed is
- Making the code harder to debug or extend

If the simplification grows into a broad refactor, stop and reassess the scope rather than continuing automatically.

### 6. Verify Before Finishing

- Re-read the edited code for behavior drift: async/ordering changes, type regressions, altered edge cases, weakened error handling
- Run the smallest relevant validation available — lint, type-check, build, or tests
- When tests are part of validation, distinguish pre-existing baseline failures from failures your change introduced — only the latter is yours to fix or revert
- Compare before and after: is the simplified version genuinely easier to understand? Is the diff clean, with no unrelated changes mixed in?
- If a "simplification" would change behavior or fight project conventions, stop and explain the tradeoff instead of forcing it

## Guardrails

- Never change what the code does — inputs, outputs, side effects, error behavior, and edge cases stay identical. If you're not sure a change preserves behavior, don't make it — flag it instead
- Do not change public APIs, storage formats, or user-visible text unless explicitly requested
- Do not weaken or remove error handling, logging, or validation
- Do not rename to personal preference — match project conventions
- Keep refactoring changes separate from feature or bug-fix changes when committing
- Do not modify tests to hide a behavior change. If a test must change because an implementation detail, mock, or test seam moved, verify the behavioral contract is unchanged before proceeding

## Output

- Make the code changes directly when the request is actionable
- Call out any uncertainty that could affect behavior before editing
- Summarize only the meaningful simplifications and the validation that was run
- If investigation finds no high-value simplification, say so and change nothing — a clean "nothing worth changing" beats forced edits
