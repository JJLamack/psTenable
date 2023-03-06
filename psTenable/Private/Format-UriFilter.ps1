function Format-UriFilter {
    <#

    .SYNOPSIS

    takes in an object, Id, or UUID strings and puts them into the correct query syntax. 

    .PARAMETER Name

    Name of the filter. should match the content done by the Tenable SC API documentatnoi

    .PARAMETER Object

    Accepts an Object, Id (Identity), or UUID (Universally Unique Identifier)

    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $true)]
        $Object
    )
    $result = $Name
    foreach ($item in $Object) {
        # Checks if given item is an object with an Id or uuid property
        if ($item.id) {
            $result += "$($item.id),"
        }
        elseif ($item.uuid) {
            $result += "$($item.uuid),"
        }
        else {
            $result += "$item,"
        }
    }
    # Adds a '&' to allow for another filter query to be put on the end
    $result = $result -replace ',$', '&'
    return $result
}