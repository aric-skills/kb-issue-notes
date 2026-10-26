---
name: knowledge-base
description: Use when the user says 【记录】【存知识库】【记下来】 to save a knowledge-base entry, or 【查知识库】【检索知识】 to search/retrieve from the knowledge base stored as GitHub Issues with the kb label in the afeiship/issue-notes repo
---

# Knowledge Base (GitHub Issues)

知识库 = GitHub Issues（仓库固定 `afeiship/issue-notes`），条目一律打 `kb` 标签。
不要写入其他项目的 issues。

## 触发词

| 指令 | 动作 |
|------|------|
| 【记录】/【存知识库】/【记下来】 | 记录流程（见下） |
| 【查知识库】/【检索知识】 | 检索流程（见下） |

其他对话不触发本 skill。

## 记录流程

1. **敏感信息过滤**：先剔除密钥、密码、token、API key、内网地址等敏感内容。
2. **查重**：搜索已有 kb issues，判断主题是否重复：
   ```bash
   gh issue list -R afeiship/issue-notes --label kb --state all --search "<关键词>" --limit 20
   ```
3. **主题已存在** → 在对应 issue 追加评论，不新建：
   ```bash
   gh issue comment <number> -R afeiship/issue-notes --body-file <file>
   ```
4. **主题不存在** → 新建 issue：
   ```bash
   gh issue create -R afeiship/issue-notes --label kb --title "<标题>" --body-file <file>
   ```
   body 用下面的固定模板，写入临时文件后 `--body-file` 提交（避免 shell 转义问题）。
5. **信息相近的内容合并**到同一 issue 持续补充，禁止随意批量创建 issue。

## 固定模板（新建 issue body）

```markdown
## 标签
<!-- 相关技术/主题标签，如 docker, git -->

## 来源
<!-- 来源项目 / 会话 / URL -->

## 核心结论
<!-- 一两句话说清结论 -->

## 细节
<!-- 命令、代码片段、步骤、坑 -->

## 待验证项
<!-- 不确定/需要后续验证的点，没有则写"无" -->
```

追加评论时复用同一结构，只填有增量的小节。

## 检索流程

```bash
gh issue list -R afeiship/issue-notes --label kb --state all --search "<关键词>" --limit 20
gh issue view <number> -R afeiship/issue-notes --comments
```

整理匹配的 issue 标题、结论、细节输出给用户；无匹配时明确说明。

## 确认门槛（必须）

**提交前必须先向用户预览将要写入的完整内容**（标题 + body 或评论内容），获得确认后才执行 `gh` 写操作。
若 gh 不可用/命令失败：直接输出格式化好的知识库 markdown 文本，告知用户手动提交，不要自行绕过。

## Red Flags

- 未经预览确认就 `gh issue create/comment`
- 写入其他仓库的 issue
- 相近主题另起新 issue 而不是评论追加
- body 里残留密钥/密码
