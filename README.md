# stevenwangking agent skills

[![skills.sh](https://skills.sh/b/stevenwangking/agent-skills)](https://skills.sh/stevenwangking/agent-skills)

A personal collection of [Agent Skills](https://agentskills.io) for coding agents, installable via the [skills CLI](https://skills.sh). 中文说明：[README.zh-CN.md](README.zh-CN.md)

## Philosophy

Every skill in this repo follows one principle: **automation with guardrails**.

- **commit — never commit past a risk unattended.** Fully automatic by default; secrets, unrelated files, and dependency changes always pause for confirmation.
- **reply-polish — over-polishing is failure.** Edits are subtractive: the author's voice and stance survive the edit; AI tone and bureaucratic filler don't.
- **simplify — behavior never changes.** Every simplification is validated with lint, types, or tests; if it can't be proven safe, it isn't made.

## Skills

| Skill | Description | Language |
| --- | --- | --- |
| [commit](skills/commit/SKILL.md) | Analyze Git changes, write a conventional commit message, auto-split per feature when themes don't mix. | 中文 |
| [reply-polish](skills/reply-polish/SKILL.md) | Polish a draft Chinese workplace reply so it sounds natural, professional, and like the author. | 中文 |
| [simplify](skills/simplify/SKILL.md) | Simplify recently changed code for clarity and reuse without changing behavior. | English |

### commit

Inspect changes → write the message from the real diff → split by feature when needed → report hashes. The message is never invented, and splitting never goes below file level.

> Triggers: `/commit` · "提交一下代码" · "帮我 commit" · `/commit amend`

### reply-polish

Takes an already-written draft — IM, email, or comment — and keeps the author's meaning and voice while removing AI tone and bureaucratic filler, calibrated to the audience. Returns one ready-to-send version.

> Triggers: "帮我改一下这段话" · "太官腔了" · "这样回复合适吗"

### simplify

Reviews what changed through three lenses (reuse, quality, efficiency) and simplifies with restraint — verified with lint, types, or tests before finishing.

> Triggers: "simplify this" · "clean up the changes" · "refactor before commit"

## Install

```bash
# Install all skills from this repo
npx skills add stevenwangking/agent-skills

# Install a single skill
npx skills add stevenwangking/agent-skills --skill commit
```

Works with any agent that supports the [Agent Skills standard](https://agentskills.io) — Claude Code, Codex, Cursor, ZCode, and [70+ others](https://github.com/vercel-labs/skills#supported-agents).

## Maintenance

The canonical copies of these skills live in `~/.agents/skills/` on the author's machine. After editing a skill locally, run `./sync.sh` — it copies changed `SKILL.md` files into this repo, commits, and pushes.

## License

[MIT](LICENSE)
