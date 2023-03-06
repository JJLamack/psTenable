function Get-TenableSCOrganization {
    <#
    
    .SYNOPSIS

    Gets a list of all Organizations

    .PARAMETER Organization

    Accepts an Organization Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties. Default displays all properities that can be returned from the Organization API endpoint except for those that can be quiered from other endpoints.

    .PARAMETER CurrentOrganization

    Filters results to only show the current organization that the user credentials provided are a part of

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Organization,
        [Parameter(ParameterSetName = 'Default', Mandatory = $false)]
        [ArgumentCompletions("id", "uuid", "name", "description", "email", "address", "city", "state", "country", "phone", "fax", "ipInfoLinks", "zoneSelection", "restrictedIPs", "vulnScoreLow", "vulnScoreMedium", "vulnScoreHigh", "vulnScoreCritical", "vulnScoringSystem", "createdTime", "modifiedTime", "passwordExpires", "passwordExpiration", "userCount", "lces", "repositories", "zones", "nessusManagers", "pubSites", "ldaps")]
        $Properties,
        [Parameter(ParameterSetName = 'Current', Mandatory = $true)]
        [switch]
        $CurrentOrganization
    )
    begin {
        $Endpoint = "organization"
    }
    process {
        if ($CurrentOrganization) {
            $result = Invoke-TenableSCMethod -Endpoint "currentOrganization"
        }
        else { 
            $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $Organization 
        }
        return $result
    }
}