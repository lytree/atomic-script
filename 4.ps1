
$RootPath = "I:\Video\"   # 根目录
$Separator = "-" 


# 遍历根目录下的所有文件夹
Get-ChildItem -Path $RootPath -Directory | ForEach-Object {
    $folder = $_
    $nameParts = $folder.Name.Split($Separator)
    $commonPart = $nameParts[0]  # 取相同部分

    # 如果 commonPart 非空且不是原文件夹本身
    if ($commonPart -and $folder.Name -ne $commonPart) {
        $targetDir = Join-Path $RootPath $commonPart

        # 创建目标目录
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir | Out-Null
        }

        # 移动文件夹
        $targetPath = Join-Path $targetDir $folder.Name
        if (-not (Test-Path $targetPath)) {
            Move-Item -Path $folder.FullName -Destination $targetDir
            Write-Host "[分类] $($folder.Name) -> $targetDir"
        } else {
            Write-Host "[跳过] 目标已存在: $targetPath"
        }
    } else {
        Write-Host "[忽略] $($folder.Name) (无分隔或已是分类名)"
    }
}
