function Get-TenableSCStatus {
    <#
    
    .SYNOPSIS

    Gets a collection of status information from Tenable Security Center

    .PARAMETER Status

    Accepts an Status Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties. All Propertiess are returned by default

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Status,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("jobd", "licenseStatus", "migrationStatus", "PluginSubscriptionStatus", "LCEPluginSubscriptionStatus", "PassivePluginSubscriptionStatus", "pluginUpdates", "feedUpdates", "activeIPs", "licensedIPs", "zoneStatus", "noLCEs", "noReps", "lastDbBackupStatus", "lastDbBackupSuccess", "lastDbBackupFailure")]
        $Properties
    )
    begin {
        $Endpoint = "status"
    }
    process {
        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $Status
        return $result
    }
}