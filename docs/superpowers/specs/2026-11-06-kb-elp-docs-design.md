# /kb-elp-docs 命令设计

日期：2026-11-06

## 目标

在 kb-issue-notes skill 中新增 `/kb-elp-docs` 快捷命令，将笔记以 GitHub Issue 形式提交到 `aric-luca/elp-docs` 仓库。

## 决策

- 提交方式：GitHub Issues（`gh issue create`），与现有 kb 流程一致
- 标签：`kb-elp-docs`（label 不存在时 gh 自动创建）
- 模板：简化版，body 只有两段（## 内容 + ## 来源，来源没有则省略）

## 改动

### 1. 新建 `.claude/commands/kb-elp-docs.md`

快捷入口命令，将 `$ARGUMENTS` 交给 knowledge-base skill 的 elp-docs 流程。

### 2. 扩展 `.claude/skills/knowledge-base/SKILL.md`

新增「elp-docs 记录流程」小节：

- 仓库固定 `aric-luca/elp-docs`，不写入其他仓库
- 触发：用户调用 `/kb-elp-docs` 命令
- 流程：敏感信息过滤 → 查重（`gh issue list -R aric-luca/elp-docs --label kb-elp-docs`）→ 预览确认 → 提交
- 简化模板：

```markdown
## 内容
<笔记正文，代码块必须带语言标识>

## 来源
<来源项目/会话/URL，没有则整节省略>
```

- gh 不可用/失败时：输出格式化 markdown 让用户手动提交

## 不变

- 主 kb 流程（afeiship/issue-notes）、触发词、确认门槛保持原样
