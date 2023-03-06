function Get-TenableSCZone {
    <#
    
    .SYNOPSIS

    Gets a list of Tenable Security Center scan zones

    .PARAMETER Zone

    Accepts an Zone Object, Id (Identity), or UUID (Universally Unique Identifier) of a Scan Zone within Tenable.sc

    .PARAMETER Properties

    Filters results returned based on the Properties given. Default behavior returns all Properties listed in argument completer

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Zone,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id", "uuid", "name", "description", "ipList", "createdTime", "modifiedTime", "organizations", "activeScanners", "totalScanners", "scanners")]
        $Properties
    )
    begin {
        $Endpoint = "zone"
    }
    process {
        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $Zone
        return $result
    }
}