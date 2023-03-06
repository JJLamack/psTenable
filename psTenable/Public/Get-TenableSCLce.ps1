function Get-TenableSCLce {
    <#
    
    .SYNOPSIS

    Gets a list of LCEs

    .PARAMETER Lce

    Accepts an LCE Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Lce,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id", "name", "description", "status", "ip", "ntpIP", "port", "username", "password", "privateKeyPassphrase", "managedRanges", "version", "downloadVulns", "vulnStatus", "lastReportTime", "createdTime", "modifiedTime", "silos", "canUse", "canManage", "organizations", "repositories")]
        $Properties
    )
    begin {
        $Endpoint = "lce"
    }
    process {
        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $Lce
        return $result
    }
}