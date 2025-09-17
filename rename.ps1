
$RootPath = "I:\Video\"   # 根目录

# Get-ChildItem "I:\Video\"  -Recurse -Filter "*" -File | ForEach-Object {
#     $newname = $_.Name -replace "fc2ppv-", "FC2-PPV-"
#     Rename-Item $_.FullName $newname
# }




# 遍历所有文件
# Get-ChildItem -Path "I:\Video\" -File | ForEach-Object {
#     $file = $_
#     # 去掉扩展名后的文件名
#     $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

#     # 目标文件夹
#     $destFolder = Join-Path "I:\Video\" $baseName

#     # 如果文件夹不存在则创建
#     if (-not (Test-Path $destFolder)) {
#         New-Item -ItemType Directory -Path $destFolder | Out-Null
#     }

#     # 移动文件
#     $destPath = Join-Path $destFolder $file.Name
#     if (-not (Test-Path $destPath)) {
#         Move-Item -Path $file.FullName -Destination $destFolder
#         Write-Host "移动: $($file.Name) -> $destFolder"
#     }
#     else {
#         Write-Host "已存在: $destPath，跳过"
#     }
# }





Get-ChildItem -Path $RootPath -Directory | ForEach-Object {
    $oldName = $_.Name
    $upperName = $oldName.ToUpper()
    Write-Host "[重命名] $oldName -> $upperName  $($oldName -ne $upperName)"
    if ($oldName -cne $upperName) {
        $tempName = "_TEMP_$oldName"

        # 先改成临时名称（避免大小写不敏感时无变化）
        Rename-Item -Path $_.FullName -NewName $tempName

        $tempPath = Join-Path $RootPath $tempName
        $finalPath = Join-Path $RootPath $upperName

        if (Test-Path $finalPath) {
            Write-Host "[合并] $oldName -> $upperName"
            # 合并内容
            Get-ChildItem -Path $tempPath | ForEach-Object {
                $dest = Join-Path $finalPath $_.Name
                if (-not (Test-Path $dest)) {
                    Move-Item -Path $_.FullName -Destination $finalPath
                }
                else {
                    Write-Host "  已存在: $dest，跳过"
                }
            }
            Remove-Item $tempPath -Recurse -Force
        }
        else {
            Rename-Item -Path $tempPath -NewName $upperName
            Write-Host "[重命名] $oldName -> $upperName"
        }
    }
}
