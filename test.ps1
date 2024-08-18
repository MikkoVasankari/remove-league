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

# Output the paths
$folderPaths

Remove-Item $folderPaths -Recurse
