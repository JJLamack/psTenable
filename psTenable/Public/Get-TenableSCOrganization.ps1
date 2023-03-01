function Get-TenableSCOrganization {
    <#
    
    .SYNOPSIS

    Gets a list of all Organizations

    .PARAMETER Organization

    Accepts an Organization Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Field

    Filters results returned based on the field. Default displays all properities that can be returned from the Organization API endpoint except for those that can be quiered from other endpoints.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Organization,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id", "uuid", "name", "description", "email", "address", "city", "state", "country", "phone", "fax", "ipInfoLinks", "zoneSelection", "restrictedIPs", "vulnScoreLow", "vulnScoreMedium", "vulnScoreHigh", "vulnScoreCritical", "vulnScoringSystem", "createdTime", "modifiedTime", "passwordExpires", "passwordExpiration", "userCount", "lces", "repositories", "zones", "nessusManagers", "pubSites", "ldaps")]
        $Field
    )
    begin {
        $Endpoint = "organization"
        $PSType = "TenableSCOrganization"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($Organization.id) {
            $Organization = $Organization.id
        }
        elseif ($Organization.uuid) {
            $Organization = $Organization.uuid
        }
        
        if ($Organization) {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $Organization -PSType $PSType -Field $Field
        }
        else {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Field $Field
        }
        return $result
    }
}