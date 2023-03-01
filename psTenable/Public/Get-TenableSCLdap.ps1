function Get-TenableSCLdap {
    <#
    
    .SYNOPSIS

    Gets a list of ldap profiles

    .PARAMETER Ldap

    Accepts an Ldap Object, Id (Identity), or UUID (Universally Unique Identifier) of an Ldap profile within Tenable.SC

    .PARAMETER Field

    Filters results returned based on the field. Default displays all properities that can be returned from the Ldap API endpoint except for those that can be quiered from other endpoints.

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Ldap,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id", "name ", "description", "searchString", "host", "port", "encryption", "dn", "dnsField", "lowercase", "timeLimit", "password", "username", "attrEmail", "attrName", "attrPhone", "attrUsername", "ldapUserProvisioning", "ldapUserSync", "createdTime", "modifiedTime", "organizations")]
        $Field
    )
    begin {
        $Endpoint = "ldap"
        $PSType = "TenableSCLdap"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($Ldap.id) {
            $Ldap = $Ldap.id
        }
        elseif ($Ldap.uuid) {
            $Ldap = $Ldap.uuid
        }
        
        if ($Ldap) {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $Ldap -PSType $PSType -Field $Field
        }
        else {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Field $Field
        }
        return $result
    }
}