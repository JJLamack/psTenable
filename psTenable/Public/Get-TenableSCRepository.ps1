function Get-TenableSCRepository {
    <#
    
    .SYNOPSIS

    Gets the repositories the user has access to.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Repository,
        [Parameter(ParameterSetName = 'Default', Mandatory = $false)]
        [Parameter(ParameterSetName = 'TypeFilter', Mandatory=$false)]
        [ArgumentCompletions("id","uuid","name","description","type","dataFormat","vulnCount","remoteID","remoteIP","running","downloadFormat","lastSyncTime","lastVulnUpdate","createdTime","modifiedTime","luminPropertiess","ipOverlaps","transfer","typePropertiess ","remoteSchedule","organizations")]
        $Properties,
        [Parameter(ParameterSetName = 'TypeFilter', Mandatory=$false)]
        [ValidateSet("All","Local","Remote","Offline")]
        $Type = "All"
    )
    begin {
        $Endpoint = "repository"
        $PSType = "TenableSCRepository"
    }
    process {
        if ($Repository) {
            $result = Get-TenableSC -Resource $Endpoint -Key $Repository -Properties $Properties
        }
        else {
            if ($Type) {
                $Endpoint += "?type=$Type"
            }
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Properties $Properties
        }
        return $result
    }
}