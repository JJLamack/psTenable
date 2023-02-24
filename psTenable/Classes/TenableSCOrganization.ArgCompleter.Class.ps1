class TenableSCOrganizationFieldsCompleter : System.Management.Automation.IArgumentCompleter {
    [System.Collections.Generic.IEnumerable[System.Management.Automation.CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $ParameterName,
        [string] $WordToComplete,
        [System.Management.Automation.Language.CommandAst] $CommandAst,
        [System.Collections.IDictionary] $FakeBoundParameters
    ) {
        $values = "id", "uuid", "name", "description", "email", "address", "city", "state", "country", "phone", "fax", "ipInfoLinks", "zoneSelection", "restrictedIPs", "vulnScoreLow", "vulnScoreMedium", "vulnScoreHigh", "vulnScoreCritical", "vulnScoringSystem", "createdTime", "modifiedTime", "passwordExpires", "passwordExpiration", "userCount", "lces", "repositories", "zones", "nessusManagers", "pubSites", "ldaps"
        return Set-TenableSCStaticArgCompleter -wordToComplete $WordToComplete -staticList $values
    }
}