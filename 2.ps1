param(
    [string]$RootPath = "I:\Video\",   # 根目录
    [string]$RemoveText = "-4K"    # 要去掉的字符或字符串
)

Get-ChildItem -Path $RootPath -Directory | ForEach-Object {
    $oldFolder = $_.FullName
    $oldName = $_.Name
    $newName = $oldName -replace [Regex]::Escape($RemoveText), ""
    $newFolder = Join-Path $RootPath $newName

    if ($oldName -ne $newName) {
        if (Test-Path $newFolder) {
            Write-Host "合并: $oldFolder -> $newFolder"
            # 把旧文件夹里的内容移过去
            Get-ChildItem -Path $oldFolder | ForEach-Object {
                $dest = Join-Path $newFolder $_.Name
                if (Test-Path $dest) {
                    Write-Host "  已存在: $dest，跳过或手动处理"
                }
                else {
                    Move-Item -Path $_.FullName -Destination $newFolder
                }
            }
            # 删除旧的空文件夹
            Remove-Item $oldFolder -Recurse -Force
        }
        else {
            Write-Host "重命名: $oldName -> $newName"
            Rename-Item -Path $oldFolder -NewName $newName
        }
    }
}
