Write-Host "Goodbye ... "

# Initialize an empty array to hold the folder paths
$folderPaths = @()

# Search all file system drives
Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    # Get all directories matching "Riot Client" on the current drive
    $folders = Get-ChildItem -Path $_.Root -Filter "Riot Client" -Directory -Recurse -ErrorAction SilentlyContinue

    # Add the paths of found folders to the $folderPaths array
    $folderPaths += $folders.FullName
}

Write-Host "Found directories:"
$folderPaths

# Remove the directories found
foreach ($path in $folderPaths) {
    try {
        # Check if the path exists before trying to remove it
        if (Test-Path -Path $path) {
            Write-Host "Removing: $path"
            Remove-Item -Path $path -Recurse -Force
        } else {
            Write-Host "Path does not exist: $path"
        }
    } catch {
        Write-Host "Failed to remove $path. Error: $_"
    }
}
