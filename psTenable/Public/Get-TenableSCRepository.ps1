function Get-TenableSCRepository {
    <#
    
    .SYNOPSIS

    Gets the repositories the user has access to.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName='Default', Mandatory=$false, Position = 0, ValueFromPipeline=$true)]
        [Alias('Id','UUID')]
        $Repository,
        [Parameter(Mandatory=$false)]
        [ValidateSet("agent","mobile","IPv4","IPv6","universal")]
        $Type
    )
    process {
        if ($Repository.ID) {
            $Repository = $Repository.Id
        } elseif ($Repository.UUID) {
            $Repository = $Repository.UUID
        }
        $fields = "id","uuid","name","description","type","dataFormat","vulnCount","remoteID","remoteIP","running","downloadFormat","lastSyncTime","lastVulnUpdate","createdTime","modifiedTime","luminFields","ipOverlaps","transfer","typeFields","remoteSchedule","organizations"

        if ($Repository) {
            $result = Invoke-TenableSCMethod -Resource "repository" -Id $Repository 
        } else {
            $result = Invoke-TenableSCMethod -Resource "repository" -Field $fields
        }
        $result
    }
}