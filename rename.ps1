Get-ChildItem "G:\Share\花生十三"  -Recurse -Filter "*" -File | ForEach-Object {
    $newname = $_.Name -replace "【公众号：上岸的资料】", ""
    Rename-Item $_.FullName $newname
}