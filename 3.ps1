$RootPath = "I:\Video\"   # 根目录
$CommonPart = "2398728943"    # 要去掉的字符串


# 目标分类目录
$targetDir = Join-Path $RootPath $CommonPart
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

# 遍历所有文件夹
Get-ChildItem -Path $RootPath -Directory | ForEach-Object {
    $folder = $_
    if ($folder.Name -like "*$CommonPart*") {
        # 避免移动目标文件夹自身
        if ($folder.FullName -ne $targetDir) {
            $destPath = Join-Path $targetDir $folder.Name
            if (-not (Test-Path $destPath)) {
                Move-Item -Path $folder.FullName -Destination $targetDir
                Write-Host "[分类] $($folder.Name) -> $targetDir"
            } else {
                Write-Host "[跳过] 目标已存在: $destPath"
            }
        }
    }
}
