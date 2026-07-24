#!/bin/bash
set -euo pipefail
TOKEN="${GITHUB_TOKEN:-}"
REPO="builder-log"
USER="OliverGarwil"
[ -z "$TOKEN" ] && echo "需要 GITHUB_TOKEN" && exit 1
curl -s -H "Authorization: token $TOKEN" -H "Accept: application/vnd.github+json" \
  -d "{\"name\":\"$REPO\",\"private\":true}" "https://api.github.com/user/repos" > /dev/null || true
git remote remove origin 2>/dev/null || true
git remote add origin "https://${TOKEN}@github.com/${USER}/${REPO}.git"
git branch -M main
git push -u origin main --force
echo "完成! https://github.com/${USER}/${REPO} (私有, 61次)"
