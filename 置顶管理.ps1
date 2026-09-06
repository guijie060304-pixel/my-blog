$ErrorActionPreference = "Stop"
Set-Location "D:\Project\my-blog"
$files = @(Get-ChildItem "source\_posts" -Filter *.md | Sort-Object Name)
Write-Host "===== 置顶管理 ====="
for ($i = 0; $i -lt $files.Count; $i++) {
  $c = [System.IO.File]::ReadAllText($files[$i].FullName)
  $state = "未置顶"
  if ($c -match '(?m)^sticky:\s*(\d+)') { $state = "已置顶 顺序$($Matches[1])" }
  Write-Host ("[{0}] {1}   ({2})" -f ($i + 1), $files[$i].Name, $state)
}
$idx = Read-Host "输入要管理的文章序号"
$f = $files[[int]$idx - 1]
Write-Host ("已选择: " + $f.Name)
Write-Host "回车 = 置顶(顺序1) | 输入数字 = 指定顺序 | 0 = 取消置顶"
$act = Read-Host "请输入"
if ($act -eq "") { $act = "1" }
$c = [System.IO.File]::ReadAllText($f.FullName)
if ($act -eq "0") {
  $c2 = $c -replace '(?m)^sticky:\s*\d+\r?\n', ''
  if ($c2 -eq $c) { Write-Host "这篇文章本来就没有置顶" } else { Write-Host "已取消置顶" }
  $c = $c2
} else {
  if ($c -match '(?m)^sticky:\s*\d+') {
    $c = $c -replace '(?m)^sticky:\s*\d+', ("sticky: " + $act)
    Write-Host ("已把置顶顺序改为 " + $act)
  } else {
    $c = $c -replace '(?m)^(date:[^\r\n]*\r?\n)', ('$1sticky: ' + $act + "`r`n")
    Write-Host ("已置顶，顺序 " + $act)
  }
}
$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($f.FullName, $c, $utf8)
$pub = Read-Host "立即发布上线? (y/n)"
if ($pub -eq "y") {
  git add -A
  git commit -m "post: update sticky"
  git push
  Write-Host "已推送，约 2 分钟后生效"
}
