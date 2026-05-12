# Personal Blog Design Spec

**Date:** 2026-05-12
**Author:** Tim Cheng (嵌入式软件工程师)
**Status:** Approved

## Overview

为嵌入式软件工程师搭建一个低成本、低维护的个人技术博客，用于写作技术文章和展示项目。用户不编写前端代码，不管理服务器，只专注于内容创作。

## Tech Stack

| 组件 | 选型 | 费用 |
|------|------|------|
| 静态网站生成器 | Hugo | 免费 |
| 主题 | Hugo Stack（卡片式布局） | 免费 |
| 代码托管 | GitHub | 免费 |
| 自动部署 | GitHub Actions | 免费 |
| 网页托管 | GitHub Pages | 免费 |
| CDN + DNS | Cloudflare（可选） | 免费 |
| 域名 | 待购买（将配置 CNAME + Cloudflare） | ~50-80 元/年 |

**总成本：仅域名年费 50-80 元。**

## Architecture

```
用户本地电脑                      云端（免费）
┌──────────────┐    git push     ┌──────────────────┐   绑 CNAME    ┌──────────┐
│ Hugo 生成     │ ──────────────> │ GitHub Pages      │ <─────────── │ 自定义域名 │
│ 静态网页      │                │ 托管于 gh-pages   │              └──────────┘
│ (Markdown     │                │ 分支              │
│  + HTML)      │                │                   │
└──────────────┘                 │ GitHub Actions    │
                                 │ 自动构建并部署     │
                                 └──────────────────┘
```

## Content Structure

```
your-blog/
├── content/
│   ├── posts/                 ← 技术文章
│   │   ├── 2024-01-15-i2c-debug.md
│   │   └── 2024-01-20-rtos-stack.md
│   ├── projects/              ← 项目展示
│   │   └── open-scope.md
│   └── about.md               ← 关于我
├── static/
│   └── images/                ← 文章图片
├── themes/
│   └── hugo-theme-stack/      ← Stack 主题（Git submodule）
├── config.toml                ← Hugo 核心配置
└── .github/workflows/
    └── deploy.yml             ← 自动部署脚本
```

### 导航结构

- 文章（可按分类筛选：嵌入式 C/C++、RTOS、硬件调试、IoT）
- 项目（每个项目有简介、技术栈、图片链接）
- 关于我（个人信息、技能、联系方式）
- 搜索

### 内容格式

- Markdown（.md）：文章和项目的主要格式
- HTML（.html）：支持独立页面使用 HTML 排版
- Markdown 内嵌 HTML：文章内可直接插入 HTML 片段
- Hugo Shortcode：可封装 HTML 为可复用组件

## Publishing Workflow

用户日常只需要 3 步：

1. **写文章** — 在 `content/posts/` 下新建 .md 文件，用任意编辑器写作
2. **本地预览** — 运行 `hugo server`，浏览器 localhost:1313 预览
3. **发布** — `git add . && git commit -m "新文章" && git push`，自动上线

## Theme: Hugo Stack

- 卡片式文章列表，项目展示效果突出
- 左侧个人信息区（头像、简介、技能标签）
- 支持分类导航和搜索
- 深色模式支持
- 代码语法高亮（内置 Chroma，支持 C/C++/汇编/Python 等）
- 每篇文章有目录（TOC）

## Deployment Pipeline

```
git push (main 分支)
    ↓
GitHub Actions 触发
    ├── Checkout 仓库
    ├── Setup Hugo
    ├── hugo build --minify
    └── Deploy to gh-pages 分支
         ↓
GitHub Pages 自动刷新
```

## Cloudflare Integration (Optional)

- DNS 托管到 Cloudflare（免费 CDN + DDoS 防护）
- 强制 HTTPS
- 全球 CDN 加速访问

## What User Needs to Provide

1. **GitHub 账号**（注册 https://github.com）
2. **域名**（购买渠道：Namecheap、阿里云万网、腾讯云）
3. 头像图片、个人简介文字

其余全部由 AI 辅助搭建。

## Out of Scope

- 评论系统（后续可按需加 Giscus 免费评论）
- 统计/分析（后续可按需加 Google Analytics 或 Umami）
- 邮件订阅
- 多语言支持
