# kb-issue-notes 安装管理
# 用法: just --list 查看, just install / just link / just uninstall

REPO_DIR := justfile_directory()
SKILL_SRC := REPO_DIR + "/.claude/skills/knowledge-base"
CMD_SRC := REPO_DIR + "/.claude/commands/kb.md"

SKILL_DST := home_directory() / ".claude" / "skills" / "knowledge-base"
CMD_DST := home_directory() / ".claude" / "commands" / "kb.md"

# 列出所有命令
_default:
    @just --list

# 软链方式安装（推荐，git pull 后全局自动同步）
install:
    mkdir -p ~/.claude/skills ~/.claude/commands
    ln -sfn "{{SKILL_SRC}}" ~/.claude/skills/knowledge-base
    ln -sf "{{CMD_SRC}}" ~/.claude/commands/kb.md
    @echo "linked: {{SKILL_DST}} -> {{SKILL_SRC}}"

# 检查安装状态
status:
    @ls -ld ~/.claude/skills/knowledge-base 2>/dev/null || echo "skill 未安装"
    @ls -l ~/.claude/commands/kb.md 2>/dev/null || echo "command 未安装"

# 卸载（同时清理软链和复制版本）
uninstall:
    rm -rf ~/.claude/skills/knowledge-base ~/.claude/commands/kb.md
    @echo "uninstalled"
