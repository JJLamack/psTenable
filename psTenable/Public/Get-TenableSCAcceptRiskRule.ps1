function Get-TenableSCAcceptRiskRule {
    <#
    
    .SYNOPSIS

    Gets a list of Accept Risk Rules

    .PARAMETER Accept Risk Rule

    Accepts an Accept Risk Rule Object, Id (Identity), or UUID (Universally Unique Identifier) of an Accepted Risk Rule within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    .PARAMETER repositoryId

    Repositories listed within Tenable Security Center.

    .PARAMETER pluginId

    Plugin Id. View Tenable SC documentation for more information.

    .PARAMETER port

    computer port number

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $AcceptRiskRule,
        [Parameter(ParameterSetName = 'Default', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Filter', Mandatory = $false)]
        [ArgumentCompletions("id", "repository", "organization", "user", "plugin", "hostType", "hostValue", "port", "protocol", "expires", "status", "comments", "createdTime", "modifiedTime")]
        $Properties,
        [Parameter(ParameterSetName = 'Filter', Mandatory = $false)]
        [Alias('RepositoryId')]
        [string]
        $Repository,
        [Parameter(ParameterSetName = 'Filter', Mandatory = $false)]
        [Alias('OrganizationId')]
        [string]
        $Organization,
        [Parameter(ParameterSetName = 'Filter', Mandatory = $false)]
        [int32]
        $PluginId,
        [Parameter(ParameterSetName = 'Filter', Mandatory = $false)]
        [ValidateRange(0, 65535)]
        [int32]
        $Port
    )
    begin {
        $Endpoint = "acceptRiskRule"
        $PSType = "TenableSCAcceptRiskRule"
    }
    process {

        # If query is for specific Accepted Risk Rule then don't use filters
        if ($PSBoundParameters.ContainsKey('AcceptRiskRule')) {
            if ($AcceptRiskRule.id) {
                $AcceptRiskRule = $AcceptRiskRule.id
            }
            elseif ($AcceptRiskRule.uuid) {
                $AcceptRiskRule = $AcceptRiskRule.uuid
            }
            $result = Invoke-TenableSCMethod -Id $AcceptRiskRule -Endpoint $Endpoint -PSType $PSType -Properties $Properties
        }
        else {
            $FilterUri = ""
            if ($Repository) {
                $repoUri = Format-UriFilter -Name "repositoryIDs" -Object $Repository
                $FilterUri += "&$repoUri"
            }
            if ($Organization) {
                $orgUri = Format-UriFilter -Name "organizationIDs" -Object $Organization
                $FilterUri += "&$orgUri"
            }
            if ($PluginId) {
                $pluginUri = Format-UriFilter -Name "pluginID" -Object $Organization
                $FilterUri += "&$pluginUri"
            }
            if ($Port) {
                $portUri = Format-UriFilter -Name "port" -Object $Port
                $FilterUri += "&$portUri"
            }
            if ($FilterUri -ne "") {
                # Remove extra '&' at start of filter
                $FilterUri = $FilterUri -replace '^&', ''
                $Endpoint += "?$FilterUri"
            }

            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Properties $Properties
        }
        return $result
    }
}