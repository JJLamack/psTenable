function Get-ScopedFileLocation {
    param (
        [System.IO.FileInfo[]]
        $Path
    )
    $result = @()
    foreach ($P in $Path) {
        $result += "$(($P.Directory).Name)\$($P.Name)"
    }
    return $result
}

# Update Module Manifest with latest Types, Formats, Exported Functions, and ScriptsToProcess
$TypesItems = @(Get-ChildItem -Path .\psTenable\Types -Recurse -Filter "*.types.ps1xml") | Sort-Object Name
$FormatItems = @(Get-ChildItem -Path .\psTenable\Formats -Recurse -Filter "*.format.ps1xml") | Sort-Object Name
$PublicItems = @(Get-ChildItem -Path .\psTenable\Public -Recurse -Filter "*.ps1") | Sort-Object Name
$UtilityItems = @(Get-ChildItem -Path .\psTenable\Utility -Recurse -Filter "*.utility.ps1") | Sort-Object Name

$TypesScopedPath = Get-ScopedFileLocation -Path $TypesItems
$FormatScopedPath = Get-ScopedFileLocation -Path $FormatItems
$UtilityScopedPath = Get-ScopedFileLocation -Path $UtilityItems
$PublicBaseNames = $PublicItems.Basename

Update-ModuleManifest -Path ".\psTenable\psTenable.psd1" -TypesToProcess $TypesScopedPath -FormatsToProcess $FormatScopedPath -ScriptsToProcess $UtilityScopedPath -FunctionsToExport $PublicBaseNames

# Cleanup in memory module and move latest copy to powershell directory to Import
Remove-Module psTenable -ErrorAction SilentlyContinue
Copy-Item H:\Projects\psTenable\psTenable\ H:\WindowsPowerShell\Modules\ -Force -Recurse
Import-Module psTenable