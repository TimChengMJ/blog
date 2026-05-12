# Personal Blog Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Hugo + Stack theme personal blog with GitHub Pages auto-deploy, for an embedded software engineer who wants zero ongoing maintenance.

**Architecture:** Local Hugo generates static files from Markdown/HTML content. Git push triggers GitHub Actions to build and deploy to GitHub Pages. Domain binds via CNAME. Cloudflare provides free CDN and HTTPS.

**Tech Stack:** Hugo (extended), Stack theme, GitHub Pages, GitHub Actions, Cloudflare DNS

---

## Task 1: Prerequisites — GitHub and Domain

**Files:** None

The user must provide these before implementation can proceed:

- [ ] **Step 1: Register GitHub account**

Go to https://github.com/signup, register a free account. Choose a username (e.g., `timcheng`).

- [ ] **Step 2: Purchase a domain**

Choose one:
- 阿里云万网: https://wanwang.aliyun.com (~55 元/年 for .com, ~29 元/年 for .cn)
- 腾讯云: https://dnspod.cloud.tencent.com
- Namecheap: https://www.namecheap.com (~$6-10/year for .com)

Buy any domain you like, e.g., `timcheng.com` or `timlab.cn`. Record the domain name — we'll need it later.

---

## Task 2: Install Hugo on Windows

**Files:** None

- [ ] **Step 1: Install Hugo via winget**

Open PowerShell as Administrator and run:

```powershell
winget install Hugo.Hugo.Extended
```

Expected output: "Successfully installed"

- [ ] **Step 2: Verify installation**

Close and reopen PowerShell (not as admin), then run:

```powershell
hugo version
```

Expected output: `hugo v0.x.x+extended windows/amd64 ...` (must say "extended")

- [ ] **Step 3: If winget fails, install manually**

Open https://github.com/gohugoio/hugo/releases/latest in browser. Download `hugo_extended_x.x.x_windows-amd64.zip`. Extract the `hugo.exe` to `C:\Users\<你的用户名>\hugo\`. Then add that folder to PATH:

```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Users\$env:USERNAME\hugo", [EnvironmentVariableTarget]::User)
```

Reopen PowerShell, run `hugo version` to verify.

---

## Task 3: Create Hugo Site Scaffold

**Files:**
- Create: `E:\AI_Support\AI_Project\TimChengBlob\` (all Hugo scaffold files)

- [ ] **Step 1: Create new Hugo site**

```powershell
hugo new site . --force
```

Run this from `E:\AI_Support\AI_Project\TimChengBlob`.

Expected: Creates `archetypes/`, `assets/`, `content/`, `data/`, `layouts/`, `static/`, `themes/`, `hugo.toml`.

- [ ] **Step 2: Initialize git for Hugo modules**

```powershell
hugo mod init github.com/<your-github-username>/<your-repo-name>
```

Replace `<your-github-username>` and `<your-repo-name>` with actual values. If you haven't decided the repo name yet, use a placeholder like `blog`:

```powershell
hugo mod init github.com/TODO/blog
```

- [ ] **Step 3: Remove default hugo.toml**

We'll create a proper config from scratch.

```powershell
Remove-Item hugo.toml
```

---

## Task 4: Add Stack Theme

**Files:**
- Create: `themes/hugo-theme-stack/` (git submodule)
- Create: `config/` directory with Hugo config files

- [ ] **Step 1: Add Stack theme as git submodule**

```powershell
git submodule add https://github.com/CaiJimmy/hugo-theme-stack themes/hugo-theme-stack
```

- [ ] **Step 2: Create Hugo config directory and main config**

```powershell
New-Item -ItemType Directory -Path "config" -Force
```

Create `config/_default/hugo.toml`:

```powershell
New-Item -ItemType Directory -Path "config/_default" -Force
```

Write `config/_default/hugo.toml`:

```toml
# Hugo 核心配置
baseURL = "https://<your-domain.com>/"
languageCode = "zh-cn"
title = "<Your Blog Name>"
theme = "hugo-theme-stack"
hasCJKLanguage = true
enableEmoji = true
paginate = 10

[permalinks]
  posts = "/posts/:slug/"
  projects = "/projects/:slug/"

[markup]
  [markup.highlight]
    noClasses = false
    style = "monokailight"
  [markup.tableOfContents]
    startLevel = 2
    endLevel = 4
```

Replace `<your-domain.com>` with your actual domain, `<Your Blog Name>` with your blog name.

- [ ] **Step 3: Create params config**

Write `config/_default/params.toml`:

```toml
[main]
  title = "<Your Blog Name>"
  subtitle = "嵌入式开发 · 技术笔记 · 项目记录"
  description = "嵌入式软件开发工程师的技术博客"

[sidebar]
  [sidebar.avatar]
    src = "/images/avatar.png"
    width = 120
    height = 120
  [sidebar.subtitle]
    content = "嵌入式工程师，热爱底层开发与开源硬件。"
  [sidebar.links]
    [[sidebar.links.main]]
      name = "GitHub"
      icon = "brands fa-github"
      url = "https://github.com/<your-username>"
      weight = 1
    [[sidebar.links.main]]
      name = "Email"
      icon = "solid fa-envelope"
      url = "mailto:<your-email>"
      weight = 2

[article]
  [article.license]
    enabled = false
  [article.math]
    enabled = false
  [article.toc]
    enabled = true

[widgets]
  enabled = ["search", "archives", "categories", "tag-cloud"]
  [widgets.categories]
    [widgets.categories.params]
      limit = 10
  [widgets.tag-cloud]
    [widgets.tag-cloud.params]
      limit = 10
  [widgets.archives]
    [widgets.archives.params]
      limit = 5
```

Replace placeholders:
- `<Your Blog Name>` → your blog name
- `<your-username>` → your GitHub username
- `<your-email>` → your email

- [ ] **Step 4: Create menu config**

Write `config/_default/menu.toml`:

```toml
[[main]]
  name = "文章"
  url = "/posts/"
  weight = 1
  [main.params]
    icon = "solid fa-newspaper"

[[main]]
  name = "项目"
  url = "/projects/"
  weight = 2
  [main.params]
    icon = "solid fa-microchip"

[[main]]
  name = "归档"
  url = "/archives/"
  weight = 3
  [main.params]
    icon = "solid fa-archive"

[[main]]
  name = "搜索"
  url = "/search/"
  weight = 4
  [main.params]
    icon = "solid fa-search"

[[main]]
  name = "关于"
  url = "/about/"
  weight = 5
  [main.params]
    icon = "solid fa-user"
```

- [ ] **Step 5: Push a waiting screen to visual companion, then commit**

```powershell
git add themes/.gitmodules themes/hugo-theme-stack config/ go.mod
git commit -m "feat: add Stack theme and Hugo config"
```

---

## Task 5: Create Content Structure and Initial Pages

**Files:**
- Create: `content/about/index.zh-cn.md`
- Create: `content/posts/_index.md`
- Create: `content/projects/_index.md`
- Create: `content/page/search/index.md`
- Create: `archetypes/posts.md`
- Create: `archetypes/projects.md`

- [ ] **Step 1: Create directories**

```powershell
New-Item -ItemType Directory -Force -Path "content/posts"
New-Item -ItemType Directory -Force -Path "content/projects"
New-Item -ItemType Directory -Force -Path "content/page/search"
New-Item -ItemType Directory -Force -Path "content/about"
New-Item -ItemType Directory -Force -Path "static/images"
```

- [ ] **Step 2: Write About page**

Write `content/about/index.zh-cn.md`:

```markdown
---
title: 关于我
description: 嵌入式软件开发工程师
date: 2026-05-12
---

## 关于我

你好，我是 Tim Cheng，一名嵌入式软件开发工程师。

### 技术栈

- **MCU/MPU:** STM32, ESP32, NXP i.MX RT
- **RTOS:** FreeRTOS, Zephyr, ThreadX
- **语言:** C, C++, Python
- **通信协议:** I2C, SPI, UART, CAN, USB
- **工具链:** GCC, Keil, J-Link, Logic Analyzer

### 关于这个博客

记录嵌入式开发中的技术心得、调试经验和项目复盘。希望对你有所帮助。
```

- [ ] **Step 3: Write Posts section index**

Write `content/posts/_index.md`:

```markdown
---
title: 文章
description: 技术文章与开发笔记
menu:
  main:
    weight: 1
---
```

- [ ] **Step 4: Write Projects section index**

Write `content/projects/_index.md`:

```markdown
---
title: 项目
description: 个人项目展示
menu:
  main:
    weight: 2
---
```

- [ ] **Step 5: Write Search page**

Write `content/page/search/index.md`:

```markdown
---
title: 搜索
slug: search
layout: search
---
```

- [ ] **Step 6: Create post archetype**

Write `archetypes/posts.md`:

```markdown
---
title: "{{ replace .Name "-" " " | title }}"
description: ""
date: {{ .Date }}
categories: [""]
tags: [""]
image: ""
draft: false
---
```

- [ ] **Step 7: Create project archetype**

Write `archetypes/projects.md`:

```markdown
---
title: "{{ replace .Name "-" " " | title }}"
description: ""
date: {{ .Date }}
tags: ["STM32", "ESP32"]
image: ""
draft: false
---

## 项目简介

## 技术方案

## 硬件设计

## 软件设计

## 效果展示
```

- [ ] **Step 8: Commit**

```powershell
git add content/ archetypes/
git commit -m "feat: add content structure and initial pages"
```

---

## Task 6: Set Up GitHub Actions Auto-Deploy

**Files:**
- Create: `.github/workflows/deploy.yml`
- Create: `.gitignore`

- [ ] **Step 1: Create .github/workflows directory**

```powershell
New-Item -ItemType Directory -Force -Path ".github/workflows"
```

- [ ] **Step 2: Write deploy workflow**

Write `.github/workflows/deploy.yml`:

```yaml
name: Deploy Hugo to GitHub Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: "latest"
          extended: true

      - name: Build
        run: hugo --minify

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

- [ ] **Step 3: Write .gitignore**

Write `.gitignore`:

```gitignore
# Hugo
/public/
/resources/_gen/
.hugo_build.lock

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Superpowers
.superpowers/
```

- [ ] **Step 4: Commit**

```powershell
git add .github/ .gitignore
git commit -m "feat: add GitHub Actions deploy workflow"
```

---

## Task 7: Push to GitHub and Enable Pages

**Files:** None (remote operations)

- [ ] **Step 1: Create GitHub repository**

Go to https://github.com/new. Repository name: `blog` (or any name you like). Keep it **Public**. Do NOT check "Add a README". Click "Create repository".

- [ ] **Step 2: Add remote and push**

```powershell
git remote add origin https://github.com/<your-username>/<repo-name>.git
git branch -M main
git push -u origin main
```

- [ ] **Step 3: Enable GitHub Pages**

In your GitHub repository: Settings → Pages → Source: "GitHub Actions". GitHub will automatically detect the workflow and deploy.

- [ ] **Step 4: Verify deployment**

After pushing, go to Actions tab in your repo. Wait for the workflow to complete (green checkmark). Your site is now live at `https://<your-username>.github.io/<repo-name>/`.

---

## Task 8: Configure Custom Domain

**Files:**
- Create: `static/CNAME`

- [ ] **Step 1: Add CNAME file**

Write `static/CNAME`:

```
<your-domain.com>
```

Just the domain name on a single line, no `https://`, no `www`.

- [ ] **Step 2: Commit and push**

```powershell
git add static/CNAME
git commit -m "feat: add custom domain CNAME"
git push
```

Wait for the deploy workflow to finish (green checkmark in Actions tab).

- [ ] **Step 3: Get GitHub Pages IP addresses**

Open https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site in browser.

Look for the current IP addresses (typically `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`).

- [ ] **Step 4: Configure DNS**

Log into your domain registrar's DNS management panel (阿里云/腾讯云/Namecheap).
Add these DNS records:

| Type | Name | Value |
|------|------|-------|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | `<your-username>.github.io` |

Save and wait for DNS propagation (1-10 minutes).

- [ ] **Step 5: Verify in GitHub**

Go to repo Settings → Pages. Under "Custom domain", type your domain and click "Save". GitHub will verify DNS. Wait for "DNS check successful" (green checkmark). Check "Enforce HTTPS".

---

## Task 9: Cloudflare CDN (Optional, Recommended)

**Files:** None

- [ ] **Step 1: Sign up at Cloudflare**

Go to https://dash.cloudflare.com/sign-up, register a free account.

- [ ] **Step 2: Add your domain to Cloudflare**

Click "Add a site" → enter your domain → choose "Free plan".

- [ ] **Step 3: Update nameservers**

Cloudflare will give you two nameserver addresses (e.g., `ada.ns.cloudflare.com`, `noah.ns.cloudflare.com`). Go to your domain registrar, change the nameservers to these. Wait for activation (up to 24 hours, usually 5-10 minutes).

- [ ] **Step 4: Configure DNS in Cloudflare**

In Cloudflare DNS settings, add the same records from Task 8 Step 4. Enable the orange cloud (proxy) for all records.

- [ ] **Step 5: Force HTTPS**

In Cloudflare: SSL/TLS → Overview → Set to "Full (strict)". Then go to Rules → Page Rules → Create rule: `https://<your-domain.com>/*` → "Always Use HTTPS" → Save.

---

## Task 10: Create First Blog Post and Verify

**Files:**
- Create: `content/posts/hello-world/index.md`

- [ ] **Step 1: Create first post using archetype**

```powershell
hugo new posts/hello-world/index.md
```

- [ ] **Step 2: Edit the post**

Write `content/posts/hello-world/index.md`:

```markdown
---
title: "Hello World"
description: "博客上线，第一篇测试文章"
date: 2026-05-12T00:00:00+08:00
categories: ["随笔"]
tags: ["博客"]
image: ""
draft: false
---

## 博客搭建完成！

这是我的第一篇博客文章。本博客使用 Hugo + Stack 主题搭建，托管在 GitHub Pages。

### 技术栈

```c
// 示例代码块
#include <stdio.h>

int main(void) {
    printf("Hello, Embedded World!\n");
    while (1) {
        // 嵌入式工程师的日常
    }
    return 0;
}
```

### 关于这个博客

这里会记录嵌入式开发的技术笔记、调试经验和项目复盘。

---

欢迎常来逛逛！🎉
```

- [ ] **Step 3: Test locally**

```powershell
hugo server -D
```

Open http://localhost:1313 in browser. Check:
- Homepage shows the post card
- Post page renders correctly (title, TOC, code highlighting)
- Navigation sidebar works
- About page loads
- Search page exists

Press Ctrl+C to stop the server.

- [ ] **Step 4: Commit and push**

```powershell
git add content/posts/hello-world/
git commit -m "feat: add hello world first post"
git push
```

- [ ] **Step 5: Verify live site**

Wait 1-2 minutes for GitHub Actions to deploy. Open `https://<your-domain.com>` in browser. Confirm:
- Site loads with HTTPS
- First post visible on homepage
- Navigation works
- Code block renders with syntax highlighting
- About page loads correctly

---

## Task 11: Update Design Spec with Actual Values

**Files:**
- Modify: `docs/superpowers/specs/2026-05-12-personal-blog-design.md`

- [ ] **Step 1: Replace TBDs in spec**

Update the spec's Tech Stack table: replace "TBD" in domain row with the actual purchased domain.

- [ ] **Step 2: Commit**

```powershell
git add docs/superpowers/specs/2026-05-12-personal-blog-design.md
git commit -m "docs: update spec with actual domain"
git push
```
