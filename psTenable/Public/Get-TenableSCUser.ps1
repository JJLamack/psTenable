function Get-TenableSCUser {
    <#
    
    .SYNOPSIS

    Gets a list of Users from Tenable Security Center. If CurrentUser flag is set then only gets the current user.

    .PARAMETER User

    Accepts an User Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    .PARAMETER CurrentUser

    Only returns the current user's data

    #>
    [cmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $User,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id", "uuid", "username", "firstname", "lastname", "status", "role", "title", "email", "address", "city", "state", "country", "phone", "fax", "createdTime", "modifiedTime", "lastLogin", "lastLoginIP", "mustChangePassword", "passwordExpires", "passwordExpiration", "passwordExpirationOverride", "passwordSetDate", "locked", "failedLogins", "authType", "fingerprint", "password", "description", "canUse", "canManage", "managedUsersGroups", "managedObjectsGroups", "preferences", "ldaps", "ldapUsername", "linkedUsers", "parent", "responsibleAsset", "group")]
        $Properties,
        [Parameter(ParameterSetName = "Org", Mandatory = $true)]
        $Organization,
        [Parameter(ParameterSetName = 'CurrentUser', Mandatory = $true)]
        [switch]
        $CurrentUser
    )
    begin {
        $Endpoint = "user"
        $PSType = "TenableSCUser"
    }
    process {
        if ($CurrentUser) {
            $result = Invoke-TenableSCMethod -Endpoint "currentUser" -Properties $Properties -PSType $PSType
        }
        elseif ($Organization) {
            $OrgUri = Format-UriFilter -Name "orgID" -Object $Organization
            $Endpoint += "?$OrgUri"
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Properties $Properties -PSType $PSType
        }
        else {
            $result = Get-TenableSC -Resource $Endpoint -Properties $Properties -Key $User
        }
        return $result
    }
}