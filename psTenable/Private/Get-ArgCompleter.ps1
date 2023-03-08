function Get-ArgCompleter {
    <#
    
    .SYNOPSIS

    returns the values used in ArgumentCompletions.

    .PARAMETER FunctionName

    Function to pull ArgumentCompletions values from.

    .PARAMETER ParameterName

    Parameter to pull ArgumentCompletions values from. Defaults to "Properties"

    .EXAMPLE

    ```powershell
    Get-ArgCompleter -FunctionName "Get-TenableSC"
    ```

    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $FunctionName,
        [Parameter(Mandatory = $false)]
        [string]
        $ParameterName = "Properties"
    )
    $ParamList = (Get-Command -Name $FunctionName).Parameters
    $ScriptBlockData = $ParamList[$ParameterName].Attributes.ScriptBlock -split ";"
    # Lazy match to get contents of argument completer object
    $M = Select-String -InputObject $ScriptBlockData[1] -Pattern "^@\((.*?)\).*"

    if ($M.Matches.Groups[1].Success) {
        return $M.Matches.Groups[1].Value
    }
    return
}