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
        [ArgumentCompletions("id","uuid","name","description","type","dataFormat","vulnCount","remoteID","remoteIP","running","downloadFormat","lastSyncTime","lastVulnUpdate","createdTime","modifiedTime","luminFields","ipOverlaps","transfer","typeFields ","remoteSchedule","organizations")]
        $Field,
        [Parameter(Mandatory=$false)]
        [ValidateSet("All","Local","Remote","Offline")]
        $Type = "All"
    )
    begin {
        if ($Repository.ID) {
            $Repository = $Repository.Id
        }
        elseif ($Repository.UUID) {
            $Repository = $Repository.UUID
        }
        $Resource = "repository"
        $PSType = "TenableSCRepository"
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