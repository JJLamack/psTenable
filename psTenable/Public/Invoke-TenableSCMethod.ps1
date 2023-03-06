function Invoke-TenableSCMethod {
    <#
    
    .SYNOPSIS

    Handles all common function API Rest calls to Tenable

    .DESCRIPTION

    .PARAMETER Endpoint

    The API URI Endpoint to call, this function will add http(s)://host and /rest to the URI as needed

    .PARAMETER Id

    Filters operations based on the ID or name

    .PARAMETER Properties

    filters what properties are returned as a results returned based on the field

    .PARAMETER PSType

    Provides Powershell Type to bind the results to.

    .PARAMETER Method

    default "GET". Web request methods

    #>
    [Alias('itm')]
    param (
        [Parameter(Position = 0)]
        $Endpoint,

        [String]
        [Alias('Name', 'UUID')]
        $Id,

        $Properties,

        $PSType,

        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method = 'GET',
        $TenableUrl = $env:TenableUrl,
        $AccessKey = $env:TenableAccessKey,
        $SecretKey = $env:TenableSecretKey
    )
    begin {
        $restParams = @{
            Headers = @{'x-apikey' = "accesskey=$AccessKey; secretkey=$SecretKey"; "accept" = "application/json" }
            Method  = $Method
        }
    }
    process {
        foreach ($EndpointItem in $Endpoint) {
            # Remove trailing "/" for uniform joining
            $uri = $TenableUrl -replace '/$', ''
            $EndpointItem = $EndpointItem -replace '^/', ''

            # Check if resource contains /rest and add if necessary
            if ($EndpointItem -match '^rest') {
                $uri += "/$EndpointItem"
            }
            else {
                $uri += "/rest/$EndpointItem"
            }

            # Get Request query items
            if ($Method -eq 'GET') {
                
                if ($Id) {
                    $uri += "/$Id"
                }
                elseif ($Properties) {
                    $propUri = Format-UriFilter -Name "fields" -Object $Properties
                    if ($uri -contains "?") {
                        # If there are other filters already in query then add fields value with an '&'
                        $uri += "&$propUri"
                    }
                    else {
                        # There are no other filters in place. add a '?' to query
                        $uri += "?$propUri"
                    }
                }

            }
        }

        try {
            Write-Verbose $uri
            $result = Invoke-RestMethod @restParams -Uri $uri
            if ($PSType) {
                foreach ($r in $result.response) {
                    $r.pstypeNames.add($PSType)
                }
            }
            return $result.Response
        }
        catch {
            if ($_.Exception.Response.StatusCode -eq 401) {
                Write-Error "Unauthorized error returned from $uri, please verify API Key and try again"
            }
            elseif ($_.Exception.Response.StatusCode -eq 403) {
                Write-Error "Unauthorized error returned from $uri, please verify API Key is correct, has access then try again"
            }
            else {
                Write-Error "Error calling $uri $($_.Exception.Message) StatusCode: $($_.Exception.Response)"
            }
            throw $_.Exception
        }
    }
}