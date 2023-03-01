function Get-TenableSCLce {
    <#
    
    .SYNOPSIS

    Gets a list of LCEs

    .PARAMETER Lce

    Accepts an LCE Object, Id (Identity), or UUID (Universally Unique Identifier) of an Organization within Tenable.SC

    .PARAMETER Properties

    Filters results returned based on the Properties.

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Lce,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id","name","description","status","ip","ntpIP","port","username","password","privateKeyPassphrase","managedRanges","version","downloadVulns","vulnStatus","lastReportTime","createdTime","modifiedTime","silos","canUse","canManage","organizations","repositories")]
        $Properties
    )
    begin {
        $Endpoint = "lce"
        $PSType = "TenableSCLce"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($Lce.id) {
            $Lce = $Lce.id
        }
        elseif ($Lce.uuid) {
            $Lce = $Lce.uuid
        }
        
        if ($Lce) {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -Id $Lce -PSType $PSType -Properties $Properties
        }
        else {
            $result = Invoke-TenableSCMethod -Endpoint $Endpoint -PSType $PSType -Properties $Properties
        }
        return $result
    }
}