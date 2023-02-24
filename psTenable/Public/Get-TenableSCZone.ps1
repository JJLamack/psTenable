function Get-TenableSCZone {
    <#
    
    .SYNOPSIS

    Gets a list of Tenable Security Center scan zones

    .PARAMETER Zone

    Accepts an Zone Object, Id (Identity), or UUID (Universally Unique Identifier) of a Scan Zone within Tenable.sc

    .PARAMETER Field

    Filters results returned based on the field. Default behavior returns all fields listed in argument completer

    #>
    [cmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Alias('Id', 'UUID')]
        $Zone,
        [Parameter(Mandatory = $false)]
        [ArgumentCompletions("id","uuid","name","description","ipList","createdTime","modifiedTime","organizations","activeScanners","totalScanners","scanners")]
        $Field
    )
    begin {
        $Resource = "zone"
        $PSType = "TenableSCZone"
    }
    process {
        # This needs to be in process to handle valuesFromPipeline
        if ($Zone.id) {
            $Zone = $Zone.id
        }
        elseif ($Zone.uuid) {
            $Zone = $Zone.uuid
        }
        
        if ($Zone) {
            $result = Invoke-TenableSCMethod -Resource $Resource -Id $Zone -PSType $PSType -Field $Field
        }
        else {
            $result = Invoke-TenableSCMethod -Resource $Resource -PSType $PSType -Field $Field
        }
        return $result
    }
}