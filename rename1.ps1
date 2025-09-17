$RootPath = "I:\Video\"   # 根目录
$RemoveText = "[456k.me]"    # 要去掉的字符串


# 递归遍历所有文件
Get-ChildItem -Path $RootPath -File -Recurse | ForEach-Object {
    $file = $_
    $oldName = $file.Name
    $newName = $oldName -replace [Regex]::Escape($RemoveText), ""
    Write-Host "[重命名] $oldName -> $newName  $($oldName -cne $newName)"
    if ($oldName -cne $newName) {
        $newPath = Join-Path $file.DirectoryName $newName

        if (-not (Test-Path $newPath)) {
            Rename-Item -Path $file.FullName -NewName $newName
            Write-Host "[重命名] $oldName -> $newName"
        } else {
            Write-Host "[跳过] 目标已存在: $newName 在 $($file.DirectoryName)"
        }
    }
}
