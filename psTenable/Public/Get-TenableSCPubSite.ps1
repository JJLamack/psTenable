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
        $PSType = "TenableSCPubSite"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($PubSite.id) {
            $PubSite = $PubSite.id
        }
        elseif ($PubSite.uuid) {
            $PubSite = $PubSite.uuid
        }
        
        if ($PubSite) {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $PubSite -PSType $PSType -Properties $Properties
        }
        else {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Properties $Properties
        }
        return $result
    }
}