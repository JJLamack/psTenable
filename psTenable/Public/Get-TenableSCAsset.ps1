function Get-TenableSCAsset {
    <#
    
    .SYNOPSIS

    Gets a list of Assets

    .PARAMETER Asset

    Accepts an Asset Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    .PARAMETER Usable

    Returns only usable Assets. Cannot be used with Manageable parameter.

    .PARAMETER Manageable

    Returns only Manageable Assets. Cannot be used with Usable parameter.

    .PARAMETER ExcludeWatchLists

    Remove Assets with 'watchlist' type from results

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Asset,
        [Parameter(ParameterSetName = 'Usable', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Manageable', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Default', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Exclude', Mandatory = $false)]
        [ArgumentCompletions("id", "uuid", "name", "description", "type", "ownerGroup", "status", "creator", "owner", "targetGroup", "groups", "template", "typePropertiess", "type", "tags", "context", "createdTime", "modifiedTime", "repositories", "ipCount", "assetDataPropertiess", "viewableIPs", "organization", "luminPropertiess")]
        $Properties,
        [Parameter(ParameterSetName = 'Usable', Mandatory = $true)]
        [switch]
        $Usable,
        [Parameter(ParameterSetName = 'Manageable', Mandatory = $true)]
        [switch]
        $Manageable,
        [Parameter(ParameterSetName = 'Usable', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Manageable', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Exclude', Mandatory = $false)]
        [switch]
        $ExcludeWatchLists,
        [Parameter(ParameterSetName = 'Usable', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Exclude', Mandatory = $false)]
        [switch]
        $ExcludeAllDefined
    )
    begin {
        $Endpoint = "asset"
        $PSType = "TenableSCAsset"
    }
    process {

        if ($Asset) {
            if ($Asset.id) {
                $Asset = $Asset.id
            }
            elseif ($Asset.uuid) {
                $Asset = $Asset.uuid
            }
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $Asset -Properties $Properties
        }
        else {
            # Create Filter
            $FilterUri = ""
            if ($Usable) {
                $FilterUri += "usable,"
            }
            if ($Manageable) {
                $FilterUri += "manageable,"
            }
            if ($ExcludeWatchLists) {
                $FilterUri += "excludeWatchlists,"
            }
            if ($ExcludeAllDefined) {
                $FilterUri += "excludeAllDefined,"
            }
            if ($FilterUri -ne "") {
                $FilterUri = $FilterUri -replace ",$", ""
                $Endpoint += "?filter=$FilterUri"
            }
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Properties $Properties
        }
        return $result
    }
}