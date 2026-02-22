# Progressive Disclosure

Token-efficient skill design through staged information loading.

## Three-Tier Loading Model

```
Tier 1: Metadata (~100 tokens)
├── name + description
├── Loaded at agent startup for ALL skills
└── Used to decide: "Is this skill relevant?"

Tier 2: SKILL.md Body (<2000 tokens)
├── Full instructions
├── Loaded when skill is triggered
└── Contains navigation to Tier 3

Tier 3: Bundled Resources (on-demand)
├── references/, scripts/, assets/
├── Loaded only when explicitly needed
└── No token cost until accessed
```

## Context Window Economics

| Scenario | Files Loaded | ~Tokens |
|----------|--------------|---------|
| Agent startup (10 skills) | Metadata only | ~1000 |
| Skill triggered | + SKILL.md | +1500 |
| Read 1 reference | + reference file | +800 |
| Full implementation | SKILL.md + 2-3 refs | ~4000 |
| **Worst case** | Everything | 10000+ |

**Key insight:** Proper navigation keeps budget at 2-5K. Poor navigation explodes to 10K+.

## File Decomposition Strategy

### Single-File vs Multi-File Decision

```
Keep in single SKILL.md when:
├─ Total content < 200 lines
├─ All content needed together
└─ No distinct "optional" sections

Split into multiple files when:
├─ Content > 200 lines
├─ Different tasks need different content
├─ Sections are mutually exclusive
└─ Large reference tables/schemas
```

### The 5-File Pattern

For complex products/domains:

```
product/
├── README.md           # Overview, quick start (always read first)
├── api.md              # Runtime APIs, types
├── configuration.md    # Setup, config files
├── patterns.md         # Best practices, examples
└── gotchas.md          # Pitfalls, debugging
```

**File size targets:**

| File | Role | Target | Max |
|------|------|--------|-----|
| README.md | Overview, routing, quick start | 80-130 lines | 200 lines |
| api.md | Runtime APIs, signatures, examples | 150-200 lines | 250 lines |
| configuration.md | Setup, config, TypeScript types | 150-200 lines | 250 lines |
| patterns.md | Workflows, best practices, full code | 150-200 lines | 250 lines |
| gotchas.md | Error-cause-solution, limits tables | 90-150 lines | 250 lines |

README files are smaller because they route; detail files are larger because they must be self-contained.

**Task-based loading:**

| Task | Files to Read |
|------|---------------|
| Quick start | README.md only |
| Implement feature | README + api + patterns |
| Configure/setup | README + configuration |
| Debug issue | gotchas.md (directly, without loading api.md) |

**Token savings:** 2-3K per task vs 5-6K reading everything.

**Why this works:** Each layer is independently useful. README alone gives a correct high-level answer. README + one detail file gives a production-grade answer. The agent can stop at any layer and still produce something useful -- information degrades gracefully rather than cliff-edging.

## Cross-Referencing

### Do: Link Without Duplicating

```markdown
## Quick Start

Basic usage here...

## Advanced Features

**Form filling**: See [forms.md](./references/forms.md)
**Batch processing**: See [batch.md](./references/batch.md)
```

Agent loads forms.md or batch.md only when needed.

### Don't: Duplicate Content

```markdown
## Quick Start
Here's how to process PDFs...

## Advanced Features
As mentioned above, to process PDFs...  # BAD: duplicates content
```

## Navigation Patterns

### "In This Reference" Section

Always include in SKILL.md:

```markdown
## In This Reference

| File | Purpose |
|------|---------|
| [api.md](./references/api.md) | Runtime APIs |
| [config.md](./references/config.md) | Setup |
| [patterns.md](./references/patterns.md) | Best practices |
| [gotchas.md](./references/gotchas.md) | Troubleshooting |
```

### "Reading Order" Section

Guide task-based navigation:

```markdown
## Reading Order

| Task | Files |
|------|-------|
| New project | README + config |
| Add feature | README + api + patterns |
| Debug | gotchas |
```

### Decision Trees for Routing

For large skills. **Frame branches by intent, not product name:**

```
# Good: intent-based (matches how users ask questions)
What do you need?
├─ Store data →
│   ├─ Key-value (config, sessions, cache) → kv/
│   ├─ Relational SQL → d1/
│   └─ Object/file storage (S3-compatible) → r2/
├─ Run code →
│   ├─ Serverless functions at the edge → workers/
│   └─ Stateful coordination/real-time → durable-objects/

# Bad: product-based (requires user to already know the answer)
Products:
├─ KV → ...
├─ D1 → ...
├─ R2 → ...
```

Decision trees can nest across layers: SKILL.md routes to products, product READMEs route to features, detail files route to specific code patterns.

### "See Also" Cross-Links

End every README.md with links to commonly co-used products:

```markdown
## See Also
- [workers](../workers/) - Runtime for KV access
- [d1](../d1/) - Use D1 for strong consistency needs
- [queues](../queues/) - Process uploads asynchronously
```

Cross-links should reflect **composition patterns** (how products are used together), not topical similarity. They pre-empt the agent's next question.

## Anti-Patterns

| Pattern | Problem | Fix |
|---------|---------|-----|
| Monolithic SKILL.md | Context rot | Split by task/domain |
| Duplicated content | Staleness, bloat | Link, don't copy |
| Missing navigation | Agent guesses wrong file | Add decision trees + reading order |
| Everything in Tier 2 | Wasted tokens on every trigger | Push details to Tier 3 |
| Product-based decision trees | Requires user to know the answer | Use intent-based framing |
| No "See Also" cross-links | Agent misses multi-product patterns | Link commonly co-used products |
| Detail files depend on each other | Must load multiple files for one task | Make each detail file self-contained |
| Gotchas mixed into api.md | Can't debug without loading full API | Separate gotchas into own file |

## See Also

- [anatomy.md](./anatomy.md) - Directory structures
- [patterns.md](./patterns.md) - Real skill patterns
- [gotchas.md](./gotchas.md) - Common mistakes
