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
2. **查重**：搜索已有 kb issues，确认没有完全相同的条目（避免原样重复）：
   ```shell
   gh issue list -R afeiship/issue-notes --label kb --state all --search "<关键词>" --limit 20
   ```
3. **默认新建 issue**：主题相近也不要往已有 issue 的评论区补充——每篇笔记保持简单、自包含、唯一。**例外**：用户明确说"追加/补充到某个 issue"时，才用评论追加：
   ```shell
   gh issue comment <number> -R afeiship/issue-notes --body-file <file>
   ```
   新建时 body 用下面的固定模板，写入临时文件后 `--body-file` 提交（避免 shell 转义问题）。
4. 每条笔记一个独立 issue，单一主题、单次记录。仅当内容与已有条目**原样重复**时才跳过写入并告知用户。

## 固定模板（新建 issue body）

```markdown
## 标签
<!-- 相关技术/主题标签，如 docker, git -->

## 来源
<!-- 来源项目 / 会话 / URL -->

## 核心结论
<!-- 一两句话说清结论 -->

## 细节
<!-- 命令、代码片段、步骤、坑。代码块必须带语言标识（如 ```bash、```js、```just、```json），禁止裸 ``` -->

## 待验证项
<!-- 不确定/需要后续验证的点，没有则写"无" -->
```

## 检索流程

```shell
gh issue list -R afeiship/issue-notes --label kb --state all --search "<关键词>" --limit 20
gh issue view <number> -R afeiship/issue-notes --comments
```

整理匹配的 issue 标题、结论、细节输出给用户；无匹配时明确说明。

## elp-docs 记录流程

目标仓库固定 `aric-luca/elp-docs`，标签 `kb-elp-docs`（label 不存在时 gh 自动创建）。
不要写入其他仓库的 issues。由 `/kb-elp-docs` 命令触发。

1. **敏感信息过滤**：同主流程。
2. **查重**：
   ```shell
   gh issue list -R aric-luca/elp-docs --label kb-elp-docs --state all --search "<关键词>" --limit 20
   ```
3. **预览确认**：同主流程确认门槛。
4. **提交**：body 用下面的简化模板，写入临时文件后 `--body-file` 提交：
   ```shell
   gh issue create -R aric-luca/elp-docs --label kb-elp-docs --title "<标题>" --body-file <file>
   ```
5. 每条笔记一个独立 issue；仅当与已有条目原样重复时跳过并告知用户。
6. gh 不可用/失败时：输出格式化好的 markdown 让用户手动提交。

### 简化模板（elp-docs issue body）

```markdown
## 内容
<笔记正文，代码块必须带语言标识（如 ```bash、```js），禁止裸 ```>

## 来源
<来源项目/会话/URL，没有则整节省略本节>
```

## 确认门槛（必须）

**提交前必须先向用户预览将要写入的完整内容**（标题 + body 或评论内容），获得确认后才执行 `gh` 写操作。
若 gh 不可用/命令失败：直接输出格式化好的知识库 markdown 文本，告知用户手动提交，不要自行绕过。

## Red Flags

- 未经预览确认就 `gh issue create/comment`
- 写入其他仓库的 issue
- 用户没明确要求追加时，往旧 issue 评论区补充——应新建独立 issue
- 为省事把多条无关笔记塞进一个 issue
- body 里残留密钥/密码
- 代码块不带语言标识（裸 ```）
