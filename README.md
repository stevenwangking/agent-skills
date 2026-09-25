# stevenwangking agent skills

[![skills.sh](https://skills.sh/b/stevenwangking/agent-skills)](https://skills.sh/stevenwangking/agent-skills)

A personal collection of [Agent Skills](https://agentskills.io) for coding agents, installable via the [skills CLI](https://skills.sh). 中文说明：[README.zh-CN.md](README.zh-CN.md)

## Skills

| Skill | Description | Language |
| --- | --- | --- |
| [commit](skills/commit/SKILL.md) | Analyze the current Git changes, generate a conventional commit message, and automatically decide whether to make a single commit or split into per-feature commits. Runs fully automatically unless an anomaly rule is hit. | 中文 |
| [reply-polish](skills/reply-polish/SKILL.md) | Polish a draft Chinese workplace reply (IM / email / comment) so it sounds natural, professional, and like the author. Preserves original meaning and personal voice; strips out AI tone and bureaucratic tone. | 中文 |
| [simplify](skills/simplify/SKILL.md) | Simplify and refine recently changed code for clarity, consistency, reuse, and maintainability without changing behavior. | English |

## Install

```bash
# Install all skills from this repo
npx skills add stevenwangking/agent-skills

# Install a single skill
npx skills add stevenwangking/agent-skills --skill commit
```

See [skills.sh](https://skills.sh) and the [skills CLI docs](https://github.com/vercel-labs/skills) for supported agents and options.

## Maintenance

The canonical copies of these skills live in `~/.agents/skills/` on the author's machine. After editing a skill locally, run:

```bash
./sync.sh
```

It copies changed `SKILL.md` files into this repo, commits, and pushes. New skills: create `skills/<name>/` locally, add the directory here, and sync picks it up automatically.

## License

[MIT](LICENSE)
