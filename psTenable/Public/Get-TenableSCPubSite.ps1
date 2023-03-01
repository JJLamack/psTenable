function Get-TenableSCPubSite {
    <#
    
    .SYNOPSIS

    Gets a list of Publishing Sites

    .PARAMETER PubSite

    Accepts an PubSite Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $PubSite,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id","name","description","type","uri","useProxy","authType","cert","username","password","verifyHost","maxChunkSize","createdTime","modifiedTime")]
        $Properties
    )
    begin {
        $Endpoint = "pubSite"
    }
    process {
        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $PubSite
        return $result
    }
}