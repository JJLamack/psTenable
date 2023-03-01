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
        $Endpoint = "repository"
        $PSType = "TenableSCRepository"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($Repository.ID) {
            $Repository = $Repository.Id
        }
        elseif ($Repository.UUID) {
            $Repository = $Repository.UUID
        }

        if ($Repository) {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $Repository -PSType $PSType -Field $Field -Type $Type
        }
        else {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Field $Field -Type $Type
        }
        return $result
    }
}