function Get-TenableSCOrganization {
    <#
    
    .SYNOPSIS

    Gets a list of all Organizations

    .PARAMETER Organization

    Accepts an Organization Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Field

    Filters results returned based on the field. Default displays all properities that can be returned from the Organization API endpoint except for those that can be quiered from other endpoints.

    #>
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Organization,
        [Parameter(ParameterSetName = 'Default', Mandatory = $false)]
        [ArgumentCompleter([TenableSCOrganizationFieldsCompleter])]
        $Field
    )
    begin {
        if ($Organization.ID) {
            $Organization = $Organization.Id
        }
        elseif ($Organization.UUID) {
            $Organization = $Organization.UUID
        }
        $Resource = "organization"
        $PSType = "TenableSCOrganization"
    }
    process {
        if ($Organization) {
            $result = Invoke-TenableSCMethod -Resource $Resource -Id $Organization -PSType $PSType -Field $Field
        }
        else {
            $result = Invoke-TenableSCMethod -Resource $Resource -PSType $PSType -Field $Field
        }
        return $result
    }
}