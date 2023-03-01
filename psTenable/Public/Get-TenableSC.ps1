function Get-TenableSC {
    <#
    
    .SYNOPSIS

    Generic "Get a Tenable SC object" call for those that do not need complex handling.

    .DESCRIPTION

    Most calls in Tenable SC have a Get-TenableSC<resource> command which gets the specifics of that type. For many types we can also use this function as most returned items do not need more than a type assignment of the results.

    .PARAMETER Resource

    The type of thing to run a Get request against. This will tab complete some object types but can also put in a custom call.

    .PARAMETER Properties

    what Propertiess should be returned by the request. If nothing specified will return the default values specified by Tenable.SC API documentation

    .PARAMETER Key

    ID or UUID of the object. If this is an object we will pull the ID or the UUID property to use.

    #>
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ArgumentCompletions("Organization")]
        $Resource,
        [Parameter(Mandatory = $false)]
        $Properties,
        [Parameter(Mandatory = $false, Position = 1, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty]
        $Key
    )

    # since Tenable.SC API camelCase's there endpoints. make sure first character is lower case on endpoint call
    $Endpoint = $Resource.substring(0,1).tolower()+$Resource.substring(1)
    # make sure first letter is uppercases for Type binding
    $PSType = "TenableSC"+$Resource.substring(0,1).toupper()+$Resource.substring(1)

    if (-not $PSBoundParameters.ContainsKey('Key')) {
        Invoke-TenableSCMethod -PSType $PSType -Endpoint $Endpoint
    }
    
    foreach ($k in $Key) {
        if ($k.id) {
            $k = $k.id
        }
        elseif ($k.uuid) {
            $k = $k.uuid
        }
        Invoke-TenableSCMethod -PSType $PSType -Endpoint $Endpoint -Properties $Properties
    }

}