# Get list of private functions and public functions to import, in order.
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter "*.ps1") | Sort-Object Name
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter "*.ps1") | Sort-Object Name

# Dot source the private function files.
foreach ($ImportItem in $Private) {
  try {
    . $ImportItem.FullName
    Write-Verbose -Message "Imported private function $($ImportItem.FullName)"
  }
  catch {
    Write-Error -Message "Failed to import private function $($ImportItem.FullName): $($_)"
  }
}

# Dot source the public function files.
foreach ($ImportItem in $Public) {
  try {
    . $ImportItem.FullName
    Write-Verbose -Message "Imported public function $($ImportItem.FullName)"
  }
  catch {
    Write-Error -Message "Failed to import public function $($ImportItem.FullName): $($_)"
  }
}

# Export the public functions.
Export-ModuleMember -Function $Public.BaseName