param (
    [string] $SEVENZIP = "C:\Program Files\7-Zip\7z.exe"
)

$buildDirectory = "build"

function Main() {
    $scriptPath = Split-Path -Parent $PSCommandPath
    Push-Location $scriptPath

    Remove-Item $buildDirectory -Recurse -Force -ErrorAction SilentlyContinue
    New-Item $buildDirectory -ItemType directory
    Push-Location .\$buildDirectory
    . $SEVENZIP a archive-with-top-level-directory.zip "..\files"
    . $SEVENZIP a archive-without-top-level-directory.zip "..\files\*"
    . $SEVENZIP x archive-with-top-level-directory.zip
    Pop-Location

    OpenDirectoryIfInIde $buildDirectory

    Pop-Location
}

function OpenDirectoryIfInIde($directory) {
    $inIde = "Windows PowerShell ISE Host" -eq $Host.Name
    if ($inIde) { explorer $directory }
}

Main
