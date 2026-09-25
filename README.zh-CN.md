# stevenwangking agent skills

[![skills.sh](https://skills.sh/b/stevenwangking/agent-skills)](https://skills.sh/stevenwangking/agent-skills)

个人维护的 [Agent Skills](https://agentskills.io) 技能合集，可通过 [skills CLI](https://skills.sh)（`npx skills`）安装到 Claude Code、Codex、Cursor 等多种编程智能体。English: [README.md](README.md)

## 技能列表

| 技能 | 说明 | 语言 |
| --- | --- | --- |
| [commit](skills/commit/SKILL.md) | 在 Git 仓库中分析当前变更，生成符合项目规范的 commit message，自动判断单次提交还是按功能拆分多次提交。正常情况全自动执行，命中异常规则（密钥凭证、无关文件混入、依赖变更等）才暂停询问。 | 中文 |
| [reply-polish](skills/reply-polish/SKILL.md) | 润色已写好的中文职场沟通回复（微信/企业微信/钉钉/邮件/评论区），保留原意和个人说话方式，去掉 AI 腔、公文腔和啰嗦客套，按受众（领导/产品/后端/同事/客户）微调语气。 | 中文 |
| [simplify](skills/simplify/SKILL.md) | 在不改变行为的前提下简化近期修改的代码，从复用、质量、效率三个视角审查，提升可读性、一致性与可维护性。 | English |

## 安装

```bash
# 安装全部技能
npx skills add stevenwangking/agent-skills

# 只安装某一个
npx skills add stevenwangking/agent-skills --skill commit
```

支持的智能体与更多选项见 [skills CLI 文档](https://github.com/vercel-labs/skills)。

## 维护

技能的唯一编辑源在作者本机的 `~/.agents/skills/`。本地修改技能后，在本仓库运行：

```bash
./sync.sh
```

脚本会自动比对仓库副本与本地源、拷贝变更、提交并推送；全部一致则不做任何改动。新增技能：本地与仓库各建 `skills/<名称>/` 目录，同步脚本会自动发现。

## 许可

[MIT](LICENSE)
