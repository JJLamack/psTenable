function Get-TenableSCUser {
    <#
    
    .SYNOPSIS

    Gets a list of Users

    .PARAMETER User

    Accepts an User Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Field

    Filters results returned based on the field.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $User,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id","uuid","username","firstname","lastname","status","role","title","email","address","city","state","country","phone","fax","createdTime","modifiedTime","lastLogin","lastLoginIP","mustChangePassword","passwordExpires","passwordExpiration","passwordExpirationOverride","passwordSetDate","locked","failedLogins","authType","fingerprint","password","description","canUse","canManage","managedUsersGroups","managedObjectsGroups","preferences","ldaps","ldapUsername","linkedUsers","parent","responsibleAsset","group")]
        $Field
    )
    begin {
        $Resource = "user"
        $PSType = "TenableSCUser"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($User.id) {
            $User = $User.id
        }
        elseif ($User.uuid) {
            $User = $User.uuid
        }
        
        if ($User) {
            $result = Invoke-TenableSCMethod -Resource $Resource -Id $User -PSType $PSType -Field $Field
        }
        else {
            $result = Invoke-TenableSCMethod -Resource $Resource -PSType $PSType -Field $Field
        }
        return $result
    }
}