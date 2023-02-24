function Set-TenableSCStaticArgCompleter {
    <#
    
    .SYNOPSIS

    Helper function to set argument completers from a static list

    .PARAMETER wordToComplete

    The parameter passed by argument completer that is set to the value the user provides before they press <tab>.

    .PARAMETER staticList

    static list of strings to set as the starting point for teh argument completer

    #>
    param (
        $wordToComplete,
        $staticList
    )

    $completionResults = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
    $startValues | Where-Object { $_ -like "$wordToComplete*"} | ForEach-Object {$completionResults.Add([System.Management.Automation.CompletionResult]::new($_,$_,'ParameterValue',$_))}
    return $completionResults
}