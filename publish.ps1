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
$commitMsg = Read-Host "提交说明（直接回车使用默认）"
if (-not $commitMsg) { $commitMsg = "update: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" }

git add .
git commit -m $commitMsg
git push
Write-Host "已发布！稍后刷新 https://timchengmj.github.io/blog/" -ForegroundColor Green
