# Common Mistakes

Issues, causes, and fixes for skill creation.

## Frontmatter Errors

| Error | Fix |
|-------|-----|
| No opening `---` | Must start at line 1 |
| Blank lines before `---` | Frontmatter must be first |
| No closing `---` | Add `---` after fields |
| XML tags `<description>` | Use YAML only |

## Name Field Errors

| Error | Bad | Good |
|-------|-----|------|
| Uppercase | `My-Skill` | `my-skill` |
| Underscores | `my_skill` | `my-skill` |
| Leading hyphen | `-my-skill` | `my-skill` |
| Trailing hyphen | `my-skill-` | `my-skill` |
| Double hyphens | `my--skill` | `my-skill` |
| Dir mismatch | Dir: `foo/`, name: `bar` | Match both |

**Valid pattern:** `^[a-z0-9]+(-[a-z0-9]+)*$`

## Description Errors

| Error | Bad | Good |
|-------|-----|------|
| Too vague | "Helps with files" | "Extract text from PDFs" |
| First person | "I help with PDFs" | "Extracts text from PDFs" |
| No trigger | "PDF tool" | "PDF tool. Use when working with PDFs." |

## Structure Errors

| Error | Fix |
|-------|-----|
| SKILL.md > 500 lines | Split to references/ |
| Duplicated content | Link, don't copy |
| Broken links | Verify paths exist |

## Script Errors

| Error | Fix |
|-------|-----|
| No shebang | Add `#!/usr/bin/env bash` |
| Silent failures | Add error handling |
| Hardcoded paths | Use relative paths |

## Validation Quick Reference

| Error Message | Fix |
|---------------|-----|
| "No frontmatter" | Add `---` at line 1 |
| "Missing name" | Add `name:` field |
| "Invalid name format" | Use lowercase-hyphens |
| "Name mismatch" | Match dir and name |
| "Missing description" | Add `description:` |
| "Description too short" | 50+ chars recommended |
| "File too large" | Split to references/ |
| "Broken link" | Fix path or create file |

## Context Rot

When too much content loads into context, the agent's attention dilutes and performance degrades. This is the primary failure mode of poorly-structured skills.

**Symptoms and causes:**

| Symptom | Cause | Fix |
|---------|-------|-----|
| Agent ignores instructions | SKILL.md too large; key instructions buried | Reduce SKILL.md, push detail to references/ |
| Wrong file accessed | No routing guidance; agent guesses | Add decision trees and reading order tables |
| Repeated questions | Cross-refs missing; agent can't find prior answers | Add "See Also" links between related files |
| Slow responses | Entire skill loaded for every task | Split into on-demand files (Tier 3) |
| Recommends wrong product | No comparison tables or decision trees | Add intent-based routing in SKILL.md |
| Generates deprecated code | Old and new patterns coexist without labels | Mark patterns with explicit `Good:` / `Bad:` |

**Prevention:** A well-structured skill keeps typical interactions at 2-5K tokens. If the agent regularly loads 10K+, the skill needs decomposition. See [progressive-disclosure.md](./progressive-disclosure.md).

## See Also

- [frontmatter.md](./frontmatter.md) - YAML spec
- [anatomy.md](./anatomy.md) - Directory structures
