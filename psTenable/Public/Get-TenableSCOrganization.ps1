function Get-TenableSCOrganization {
    param (
        [Parameter(ParameterSetName='Default', Mandatory=$false, Position = 0, ValueFromPipeline=$true)]
        [Alias('Id','UUID')]
        $Organization
    )
    process {
        if ($Organization.ID) {
            $Organization = $Organization.Id
        } elseif ($Organization.UUID) {
            $Organization = $Organization.UUID
        }
        
        # per Tenable.sc API documentation all fields will be returned by default. This behavior will change in upcoming release.
        #$fields = "*id","*uuid","**name","**description","email","address","city","state","country","phone","fax","ipInfoLinks","zoneSelection","restrictedIPs","vulnScoreLow","vulnScoreMedium","vulnScoreHigh","vulnScoreCritical","vulnScoringSystem","createdTime","modifiedTime","passwordExpires","passwordExpiration","userCount","lces","repositories","zones","nessusManagers","pubSites","ldaps"
        
        if ($Organization) {
            $result = Invoke-TenableSCMethod -Resource "organization" -Id $Organization -PSType TenableSCOrganization
        } else {
            $result = Invoke-TenableSCMethod -Resource "organization" -PSType TenableSCOrganization
        }
        return $result
    }
}