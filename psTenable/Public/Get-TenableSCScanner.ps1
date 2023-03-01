function Get-TenableSCScanner {
    <#
    
    .SYNOPSIS

    Gets a list of Scanners

    .PARAMETER Scanner

    Accepts an Scanner Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Scanner,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id","name","description","status","ip","port","useProxy","enabled","verifyHost","managePlugins","authType","cert","username","password","agentCapable","version","webVersion","admin","msp","numScans","numHosts","numSessions","numTCPSessions","loadAvg","uptime","statusMessage","pluginSet","loadedPluginSet","serverUUID","createdTime","modifiedTime","accessKey","secretKey","zones","nessusManagerOrgs")]
        $Properties
    )
    begin {
        $Endpoint = "scanner"
    }
    process {
        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $Scanner
        return $result
    }
}