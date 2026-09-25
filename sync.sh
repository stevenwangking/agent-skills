#!/usr/bin/env bash
# 将本地全局技能同步到本仓库并推送。
# 用法：编辑 ~/.agents/skills/<name>/SKILL.md 后，在本仓库任意位置运行 ./sync.sh
set -euo pipefail

SOURCE_DIR="${SKILLS_SOURCE_DIR:-${HOME}/.agents/skills}"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

updated=0
for dest_dir in "${REPO_DIR}"/skills/*/; do
  name="$(basename "$dest_dir")"
  src="${SOURCE_DIR}/${name}/SKILL.md"
  dest="${dest_dir}SKILL.md"
  if [[ ! -f "$src" ]]; then
    echo "跳过 ${name}：本地源不存在（${src}）"
    continue
  fi
  if cmp -s "$src" "$dest"; then
    echo "无变化：${name}"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "已更新：${name}"
    updated=$((updated + 1))
  fi
done

cd "$REPO_DIR"
if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -m "sync: update skills from local ~/.agents/skills"
  git push
  echo "已提交并推送（更新 ${updated} 个技能）。"
else
  echo "仓库无变更，无需提交。"
fi
