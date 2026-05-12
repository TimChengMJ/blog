<#
.SYNOPSIS
  创建新文章
.EXAMPLE
  .\new.ps1 "FreeRTOS 任务栈溢出调试"
#>
param([string]$title)

if (-not $title) { $title = Read-Host "文章标题" }
$slug = $title -replace '[^\w一-鿿]+', '-' -replace '-+', '-' -replace '^-|-$', ''
hugo new posts/$slug/index.md
$file = "content/posts/$slug/index.md"
Write-Host "已创建: $file" -ForegroundColor Green
if (Get-Command code -ErrorAction SilentlyContinue) {
    code $file
} else {
    notepad $file
}
