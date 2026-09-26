#!/usr/bin/env bash
# 将本地全局技能同步到本发布仓库并推送。
# 同步范围 = 本仓库 skills/ 下已有目录（白名单）；本地未收录的技能不会被发布。
# 用法：任意目录下用绝对路径运行 ~/ZCodeProject/agent-skills/sync.sh
set -euo pipefail

SOURCE_DIR="${SKILLS_SOURCE_DIR:-${HOME}/.agents/skills}"  # 源目录可用环境变量覆盖（测试用）
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

updated=()
for dest_dir in "${REPO_DIR}"/skills/*/; do
  name="$(basename "$dest_dir")"
  src="${SOURCE_DIR}/${name}/SKILL.md"
  if [[ ! -f "$src" ]]; then
    echo "跳过 ${name}：本地源不存在（${src}）"
    continue
  fi
  if cmp -s "$src" "${dest_dir}SKILL.md"; then
    echo "无变化：${name}"
  else
    cp "$src" "${dest_dir}SKILL.md"
    echo "已更新：${name}"
    updated+=("$name")
  fi
done

cd "$REPO_DIR"
if [[ ${#updated[@]} -gt 0 ]]; then
  # 只暂存技能文件，避免把仓库里其他未提交改动（如 README）卷进同步提交
  git add skills/
  git commit -m "sync: update ${updated[*]}"
fi

# 有未推送的提交就推送（含上次推送失败遗留的）
ahead="$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)"
if [[ "$ahead" -gt 0 ]]; then
  git push || { echo "推送失败：提交已保留在本地，网络恢复后重跑本脚本或手动 git push"; exit 1; }
  if [[ ${#updated[@]} -gt 0 ]]; then
    echo "已提交并推送：${updated[*]}"
  else
    echo "已补推上次遗留的提交（本次无新变更）。"
  fi
else
  echo "仓库无变更，无需提交。"
fi
