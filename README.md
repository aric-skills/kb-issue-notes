# kb-issue-notes

基于 GitHub Issues 的个人知识库（Claude Code skill）。条目 = `afeiship/issue-notes` 仓库中带 `kb` 标签的 issue，通过 `knowledge-base` skill 自动记录与检索。

## 结构

```
.claude/skills/knowledge-base/SKILL.md   # skill 定义
.claude/commands/kb.md                   # /kb 快捷命令
```

知识内容不存放在仓库文件中，而是存放在 `afeiship/issue-notes` 的 Issues 里。

## 安装到全局（任意项目可用）

前提：已安装 [Claude Code](https://claude.com/claude-code) 和 [gh CLI](https://cli.github.com/)（已 `gh auth login`）。

方式一：克隆本仓库后复制

```bash
git clone https://github.com/afeiship/kb-issue-notes.git
cd kb-issue-notes

# 全局安装 = 复制到 ~/.claude（对所有项目生效）
mkdir -p ~/.claude/skills ~/.claude/commands
cp -r .claude/skills/knowledge-base ~/.claude/skills/
cp .claude/commands/kb.md ~/.claude/commands/
```

方式二：软链（推荐，本仓库 `git pull` 更新后全局自动同步）

```bash
git clone https://github.com/afeiship/kb-issue-notes.git
mkdir -p ~/.claude/skills ~/.claude/commands
ln -sfn "$(pwd)/kb-issue-notes/.claude/skills/knowledge-base" ~/.claude/skills/knowledge-base
ln -sf "$(pwd)/kb-issue-notes/.claude/commands/kb.md" ~/.claude/commands/kb.md
```

方式三：直接 curl 单文件安装（仓库发布后可用 raw 地址）

```bash
mkdir -p ~/.claude/skills/knowledge-base ~/.claude/commands
curl -o ~/.claude/skills/knowledge-base/SKILL.md https://raw.githubusercontent.com/afeiship/kb-issue-notes/main/.claude/skills/knowledge-base/SKILL.md
curl -o ~/.claude/commands/kb.md https://raw.githubusercontent.com/afeiship/kb-issue-notes/main/.claude/commands/kb.md
```

安装后重启 Claude Code 会话即可生效（新会话会重新加载 skills/commands）。

> 方式二软链的好处：skill 内容随本仓库更新，`git pull` 一次即可全局生效，无需重复复制。

### 仅当前项目使用

把 `.claude/` 下的两个文件复制到目标项目根目录的相同路径即可。

## 使用方法

在任意 Claude Code 会话中：

### 记录

- 【记录】xxx
- 【存知识库】xxx
- 【记下来】xxx
- 或快捷命令：`/kb 记录:xxx`

流程：过滤敏感信息 → 检索已有 kb issues 查重 → 主题已存在则在对应 issue 追加评论，不存在则新建 issue → **先预览内容，确认后才提交**。

### 检索

- 【查知识库】关键词
- 【检索知识】关键词
- 或快捷命令：`/kb 查询:关键词`

Claude 会搜索 kb issues 并整理匹配结果返回。

## 条目模板

每个 kb issue 使用固定结构：

```markdown
## 标签
## 来源
## 核心结论
## 细节
## 待验证项
```

## 手动操作

不经过 skill 时可用 gh cli 直接管理：

```bash
# 列出所有知识库条目
gh issue list -R afeiship/issue-notes --label kb --state all

# 查看某条
gh issue view <number> -R afeiship/issue-notes --comments

# 新建
gh issue create -R afeiship/issue-notes --label kb --title "标题" --body-file body.md
```
