function Get-TenableSCLdap {
    <#
    
    .SYNOPSIS

    Gets a list of ldap profiles

    .PARAMETER Ldap

    Accepts an Ldap Object, Id (Identity), or UUID (Universally Unique Identifier) of an Ldap profile within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties. Default displays all properities that can be returned from the Ldap API endpoint except for those that can be quiered from other endpoints.

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Ldap,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id", "name ", "description", "searchString", "host", "port", "encryption", "dn", "dnsProperties", "lowercase", "timeLimit", "password", "username", "attrEmail", "attrName", "attrPhone", "attrUsername", "ldapUserProvisioning", "ldapUserSync", "createdTime", "modifiedTime", "organizations")]
        $Properties
    )
    begin {
        $Endpoint = "ldap"
    }
    process {

        # Wildcard to return all properties of an endpoint
        if ("*" -eq $Properties) {
            $Properties = Get-ArgCompleter -FunctionName $MyInvocation.MyCommand
        }

        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $Ldap
        return $result
    }
}