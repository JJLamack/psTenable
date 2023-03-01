function Get-TenableSCArgList {
    param (
        $wordToComplete,
        [Parameter()]
        [TypeName]
        $Endpoint,
        $PropertyName
    )
    
    $results = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
    $wordToComplete = $wordToComplete -replace "^`"|^'|'$|`"$", ''
}

class TenableSCGenericNamesCompleter : System.Management.Automation.IArgumentCompleter {
    [System.Collections.Generic.IEnumerable[System.Management.Automation.CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $ParameterName,
        [string] $WordToComplete,
        [System.Management.Automation.Language.CommandAst] $CommandAst,
        [System.Collections.IDictionary] $FakeBoundParameters
    ) {
        $CompletionResults = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
        
        
        
        return $CompletionResults
    }
}