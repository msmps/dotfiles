# Real-World Skill Patterns

Concrete patterns with examples.

## Pattern 1: Workflow-Based

For sequential, multi-step processes.

```
release-manager/
├── SKILL.md
└── references/changelog-format.md
```

**Example frontmatter:**
```yaml
name: release-manager
description: Create releases with changelogs. Use when preparing release or bumping versions.
```

**Key sections:** Numbered steps, decision tables, checklists.

**When to use:** Clear step order, steps depend on previous steps.

## Pattern 2: Task-Based

For tool collections with independent operations.

```
pdf-processor/
├── SKILL.md
└── scripts/
    ├── extract_text.sh
    └── merge_pdfs.sh
```

**Example frontmatter:**
```yaml
name: pdf-processor
description: Extract, merge, split PDF files. Use when working with PDFs.
```

**Key sections:** Operation catalog, command reference, script index.

**When to use:** Independent operations, no required order.

## Pattern 3: Reference/Guidelines

For standards, specs, policies.

```
code-standards/
├── SKILL.md
└── references/
    ├── naming.md
    └── testing.md
```

**Example frontmatter:**
```yaml
name: code-standards
description: Team coding standards. Use when writing code or reviewing PRs.
```

**Key sections:** Quick reference tables, links to detailed docs.

**When to use:** Established standards, consistency enforcement.

## Pattern 4: Platform

For large platforms with many products. See [cloudflare/skills/tree/main/skills/cloudflare](https://github.com/cloudflare/skills/tree/main/skills/cloudflare) as the reference implementation (61 products, 307 files).

```
cloud-platform/
├── SKILL.md                    # Router ONLY: decision trees + product index
└── references/
    ├── compute/
    │   ├── README.md           # Overview, quick start, reading order, see also
    │   ├── api.md              # Runtime APIs
    │   ├── configuration.md    # Setup/config
    │   ├── patterns.md         # Best practices, full code examples
    │   └── gotchas.md          # Error-cause-solution triplets, limits
    └── storage/
        └── ... (same 5-file structure)
```

**Example frontmatter:**
```yaml
name: cloud-platform
description: Cloud platform covering compute, storage, networking, and security. Use for any platform development task.
references:
  - compute        # Hot-path: auto-load most common product READMEs
  - storage
```

**Required techniques:**

1. **SKILL.md contains zero implementation detail** -- only intent-based decision trees and a product index. Its sole job is routing.
2. **Decision trees organized by intent** -- "I need to store data" not "Use product X." Users describe problems; the tree matches problems to products.
3. **Frontmatter `references` for hot-path** -- pre-load the 3-5 most common product READMEs. The agent answers majority of questions without additional reads.
4. **Uniform 5-file schema per product** -- agent always knows what files exist without listing directories.
5. **Reading Order tables in every README** -- map tasks to file sequences so the agent never guesses which detail file to load.
6. **"See Also" cross-links** -- end every README with links to commonly co-used products, reflecting real composition patterns.
7. **Gotchas with error-message headers** -- `### "Error text"` format lets agents match pasted errors directly.

**When to use:** 5+ products, different products for different tasks.

## Pattern 5: Integration

For API wrappers and external services.

```
github-automation/
├── SKILL.md
└── references/api.md
```

**Example frontmatter:**
```yaml
name: github-automation
description: GitHub operations via gh CLI. Use for PRs, issues, releases.
```

**Key sections:** Common operations, API reference link, MCP tool notes.

**When to use:** External service integration, CLI wrapper docs.

## Combining Patterns

Most skills combine patterns:

```
deployment-pipeline/            # Workflow + Integration
├── SKILL.md                    # Workflow steps
├── references/github-api.md    # Integration reference
└── scripts/deploy.sh           # Task automation
```

## Pattern Selection

| Need | Pattern |
|------|---------|
| Step-by-step process | Workflow |
| Multiple operations | Task-based |
| Standards/rules | Reference |
| Many products | Platform |
| External service | Integration |

## See Also

- [anatomy.md](./anatomy.md) - Directory structures
- [progressive-disclosure.md](./progressive-disclosure.md) - Token management
