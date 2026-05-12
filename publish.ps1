<#
.SYNOPSIS
  预览或发布博客
.EXAMPLE
  .\publish.ps1              # 发布到线上
  .\publish.ps1 -Preview     # 本地预览
#>
param([switch]$Preview)

if ($Preview) {
    Write-Host "本地预览: http://localhost:1313" -ForegroundColor Green
    Write-Host "按 Ctrl+C 停止" -ForegroundColor Yellow
    hugo server -D
    return
}

$msg = git status --short
if (-not $msg) {
    Write-Host "没有需要发布的更改" -ForegroundColor Yellow
    return
}

Write-Host "变更文件:" -ForegroundColor Cyan
Write-Host $msg

# ===== 排版校验 =====
Write-Host "`n正在校验排版..." -ForegroundColor Cyan
$buildResult = hugo --minify 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "BUILD FAILED — 请修复后重试" -ForegroundColor Red
    Write-Host $buildResult
    return
}

# 检查中文乱码
$garbled = Select-String -Path "public\posts\*\index.html" -Pattern "鏇存柊" -SimpleMatch -ErrorAction SilentlyContinue
if ($garbled) {
    Write-Host "WARNING: 发现疑似中文乱码，请检查编码" -ForegroundColor Yellow
    Write-Host $garbled.Path
}

# 检查表格溢出风险
$wideTables = Select-String -Path "public\posts\*\index.html" -Pattern "overflow-x:auto|overflow-x: auto" -SimpleMatch -ErrorAction SilentlyContinue
$tables = Select-String -Path "public\posts\*\index.html" -Pattern "<table" -SimpleMatch -ErrorAction SilentlyContinue
if ($tables -and -not $wideTables) {
    Write-Host "WARNING: 文章含表格但未设置 overflow-x，移动端可能溢出" -ForegroundColor Yellow
}

Write-Host "校验通过" -ForegroundColor Green

$commitMsg = Read-Host "`n提交说明（直接回车使用默认）"
if (-not $commitMsg) { $commitMsg = "update: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" }

git add .
git commit -m $commitMsg
git push
Write-Host "已发布！稍后刷新 https://timchengmj.github.io/blog/" -ForegroundColor Green
