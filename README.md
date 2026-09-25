# stevenwangking agent skills

A personal collection of [Agent Skills](https://agentskills.io) for coding agents, installable via the [skills CLI](https://skills.sh).

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

## License

[MIT](LICENSE)
