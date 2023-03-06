function New-TenableSCAcceptRiskRule {
    <#
    
    .SYNOPSIS

    Creates a new Accept Risk Rule in Tenable.SC

    .PARAMETER Repository

    .PARAMETER Plugin

    .PARAMETER HostType

    .PARAMETER Port

    .PARAMETER Protocol

    .PARAMETER Comments

    .PARAMETER ExpiresDate

    #>
    param (
        [Parameter(Mandatory = $true)]
        $Repository,
        [Parameter(Mandatory = $true)]
        $Plugin,
        [Parameter(Mandatory = $false)]
        [ValidateSet("all", "asset", "ip", "uuid", "hostUUID")]
        [string]
        $HostType = "all",
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, 65535)]
        [int]
        [string]
        $Port = "any",
        [Parameter(Mandatory = $false)]
        [int]
        [string]
        $Protocol = "any",
        [Parameter(Mandatory = $true)]
        [string]
        $Comments = "",
        [Parameter(Mandatory = $true)]
        [datetime]
        $ExpiresDate
    )
    begin {
        $Endpoint = "acceptRiskRule"
        $PStype = "TenableSCAcceptRiskRule"
    }
    process {
        $result = [PSCustomObject]@{
            repositories = $Repository
            plugin       = $Plugin
            hostType     = $HostType
            port         = $Port
            protocol     = $Protocol
            comments     = $Comments
            expires      = $(Get-Date -Date $ExpiresDate -UFormat %s)
        }
        $Json = $result | ConvertTo-Json

        $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Method "Post" -PSType $PStype -JsonBody $Json
        return $result
    }
}