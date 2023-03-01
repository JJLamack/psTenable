function Get-TenableSCStatus {
    <#
    
    .SYNOPSIS

    Gets a collection of status information from Tenable Security Center

    .PARAMETER Status

    Accepts an Status Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties. All Propertiess are returned by default

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Status,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("jobd","licenseStatus","migrationStatus","PluginSubscriptionStatus","LCEPluginSubscriptionStatus","PassivePluginSubscriptionStatus","pluginUpdates","feedUpdates","activeIPs","licensedIPs","zoneStatus","noLCEs","noReps","lastDbBackupStatus","lastDbBackupSuccess","lastDbBackupFailure")]
        $Properties
    )
    begin {
        $Endpoint = "status"
        $PSType = "TenableSCStatus"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($Status.id) {
            $Status = $Status.id
        }
        elseif ($Status.uuid) {
            $Status = $Status.uuid
        }
        
        if ($Status) {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $Status -PSType $PSType -Properties $Properties
        }
        else {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Properties $Properties
        }
        return $result
    }
}