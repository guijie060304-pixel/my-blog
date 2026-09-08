$ErrorActionPreference = "Stop"
Set-Location "D:\Project\my-blog"
Write-Host "===== 新建文章（逐项填写，回车可跳过）====="
$title = Read-Host "1/5 文章标题(必填)"
if ($title -eq "") { Write-Host "标题不能为空"; exit }
$desc = Read-Host "2/5 一句话简介(回车跳过)"
$cat = Read-Host "3/5 分类·一篇一个(回车跳过，如：技术)"
$tags = Read-Host "4/5 标签·逗号隔开(回车跳过，如：Hexo,Git)"
$cover = Read-Host "5/5 封面图片文件名(回车跳过；图片稍后放进同名文件夹)"
$file = "source\_posts\$title.md"
if (Test-Path $file) {
  Write-Host "这篇文章已存在：$file"
  $o = Read-Host "直接打开它? (y/n)"
  if ($o -eq "y") {
    $v = "$env:LocalAppData\Programs\Microsoft VS Code\Code.exe"
    if (Test-Path $v) { Start-Process $v (Join-Path (Get-Location) $file) } else { Start-Process notepad (Join-Path (Get-Location) $file) }
  }
  exit
}
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$day = Get-Date -Format "yyyy/MM/dd"
if ($desc -eq "") { $descLine = "description:" } else { $descLine = "description: $desc" }
if ($cat -eq "") { $catLine = "categories:" } else { $catLine = "categories: [$cat]" }
if ($tags -eq "") {
  $tagsLine = "tags:"
} else {
  $t = $tags -split "[,，、]" | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
  $tagsLine = "tags: [" + ($t -join ", ") + "]"
}
$lines = @("---", "title: $title", "date: $date", $descLine, $catLine, $tagsLine)
if ($cover -ne "") { $lines += "cover: /$day/$title/$cover" }
$lines += "---"
$content = ($lines -join "`r`n") + "`r`n`r`n在这里开始写正文。`r`n"
$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $file), $content, $utf8)
New-Item -ItemType Directory -Force -Path "source\_posts\$title" | Out-Null
Write-Host ""
Write-Host "文章已创建：source\_posts\$title.md"
Write-Host "图片文件夹已就绪：source\_posts\$title\（截图可 Ctrl+Alt+V 直接粘贴）"
$open = Read-Host "立即打开编辑器写作? (y/n)"
if ($open -eq "y") {
  $v = "$env:LocalAppData\Programs\Microsoft VS Code\Code.exe"
  if (Test-Path $v) { Start-Process $v (Join-Path (Get-Location) "source\_posts\$title.md") } else { Start-Process notepad (Join-Path (Get-Location) "source\_posts\$title.md") }
}
