<#

.SYNOPSIS

Creates consistant build each time the module needs to be tested during development and release

.NOTES

Must verify necessary modules are installed & updated.
Format documents?
Verify module with PSScriptAnalyzer
Verify Manifest with Test-ModuleManifest
Run Pester Tests


#>
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

Update-ModuleManifest -Path "$((Get-Location).Path)\psTenable\psTenable.psd1" -TypesToProcess $TypesScopedPath -FormatsToProcess $FormatScopedPath -ScriptsToProcess $UtilityScopedPath -FunctionsToExport $PublicBaseNames

# If release 
#   create version on site
#   update manifest number (figure out way to auto bump version number based on [Major].[Minor].[Patch] semaphoric versioning)

# Cleanup in memory module and move latest copy to powershell directory to Import
Remove-Module psTenable -ErrorAction SilentlyContinue
Import-Module -Name "$((Get-Location).Path)\psTenable"

# Create Documentation with Docusaurus
$docparameters = @{
    Module = "$((Get-Location).Path)\psTenable"
    DocsFolder = ".\website\docs"
    Sidebar = "commands"
    MetaKeywords = @(
        "PowerShell"
        "Documentation"
    )
}
$Null = New-DocusaurusHelp @docparameters