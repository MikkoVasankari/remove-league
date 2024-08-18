Write-Host "Goodbye ... "

$folderPaths = @()

Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $folders = Get-ChildItem -Path $_.Root -Filter "Riot Client" -Directory -Recurse -ErrorAction SilentlyContinue

    $folderPaths += $folders.FullName
}

Write-Host "Found directories:"
$folderPaths

foreach ($path in $folderPaths) {
    try {
        if (Test-Path -Path $path) {
            Write-Host "Removing: $path"
            Remove-Item -Path $path -Recurse -Force
    } catch {
        Write-Host "Failed to remove $path. Error: $_"
    }
}
