function Get-TenableSCOrganization {
    <#
    
    .SYNOPSIS

    Gets a list of all Organizations

    .PARAMETER Organization

    Accepts an Organization Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Field

    Filters results returned based on the field. Default displays all properities that can be returned from the Organization API endpoint except for those that can be quiered from other endpoints.

    #>
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Organization,
        [Parameter(ParameterSetName = 'Default', Mandatory = $false)]
        [ArgumentCompleter({
            [OutputType([System.Management.Automation.CompletionResult])]
            param(
                [string] $CommandName,
                [string] $ParameterName,
                [string] $WordToComplete,
                [System.Management.Automation.Language.CommandAst] $CommandAst,
                [System.Collections.IDictionary] $FakeBoundParameters
            )
            
            $CompletionResults = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
            
            $startValues = "id","uuid","name","description","email","address","city","state","country","phone","fax","ipInfoLinks","zoneSelection","restrictedIPs","vulnScoreLow","vulnScoreMedium","vulnScoreHigh","vulnScoreCritical","vulnScoringSystem","createdTime","modifiedTime","passwordExpires","passwordExpiration","userCount","lces","repositories","zones","nessusManagers","pubSites","ldaps"
            $possibleValues = $startValues | Where-Object { $_ -like "$WordToComplete*"}
            $possibleValues | ForEach-Object {$CompletionResults.Add([System.Management.Automation.CompletionResult]::new($_,$_,'ParameterValue',$_))}
            return $CompletionResults
        })]
        $Field
    )
    begin {
        if ($Organization.ID) {
            $Organization = $Organization.Id
        }
        elseif ($Organization.UUID) {
            $Organization = $Organization.UUID
        }
        $Resource = "organization"
        $PSType = "TenableSCOrganization"
    }
    process {
        if ($Organization) {
            $result = Invoke-TenableSCMethod -Resource $Resource -Id $Organization -PSType $PSType -Field $Field
        }
        else {
            $result = Invoke-TenableSCMethod -Resource $Resource -PSType $PSType -Field $Field
        }
        return $result
    }
}