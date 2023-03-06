function Get-TenableSCUser {
    <#
    
    .SYNOPSIS

    Gets a list of Users

    .PARAMETER User

    Accepts an User Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $User,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id","uuid","username","firstname","lastname","status","role","title","email","address","city","state","country","phone","fax","createdTime","modifiedTime","lastLogin","lastLoginIP","mustChangePassword","passwordExpires","passwordExpiration","passwordExpirationOverride","passwordSetDate","locked","failedLogins","authType","fingerprint","password","description","canUse","canManage","managedUsersGroups","managedObjectsGroups","preferences","ldaps","ldapUsername","linkedUsers","parent","responsibleAsset","group")]
        $Properties
    )
    begin {
        $Endpoint = "user"
    }
    process {
        $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $User
        return $result
    }
}