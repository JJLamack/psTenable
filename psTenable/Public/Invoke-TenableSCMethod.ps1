function Invoke-TenableSCMethod {
    <#
    
    .SYNOPSIS

    Handles all common function API Rest calls to Tenable

    .DESCRIPTION

    .PARAMETER Resource

    The API URI resource to call, this function will add http(s)://host and /rest as needed

    .PARAMETER Id

    Filters operations based on the ID or name

    #>
    [Alias('itm')]
    param (
        [Parameter(Position=0)]
        $Resource,

        [String]
        [Alias('Name','UUID')]
        $Id,

        $Field,

        $PSType,

        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method = 'GET',
        $TenableUrl = $env:TenableUrl,
        $AccessKey = $env:TenableAccessKey,
        $SecretKey = $env:TenableSecretKey
    )
    begin {
        $restParams = @{
            Headers = @{'x-apikey' = "accesskey=$AccessKey; secretkey=$SecretKey"; "accept" = "application/json"}
            Method = $Method
        }
    }
    process {
        foreach ($r in $Resource) {
            # Remove trailing "/" for uniform joining
            $uri = $TenableUrl -replace '/$',''
            $r = $r -replace '^/',''

            # Check if resource contains /rest and add if necessary
            if ($r -match '^rest') {
                $uri += "/$r"
            } else {
                $uri += "/rest/$r"
            }

            # add ID to URI if it exists and is a GET request
            if($Id -and $Method -eq 'GET') {
                $uri += "/$Id"
            }

            # Add Fields to URI if exists
            if($Field) {
                $uri += "?fields="
                foreach ($f in $Field) {
                    $uri += "$f,"
                }
                $uri = $uri -replace ',$',''
            }

            try {
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
                } elseif ($_.Exception.Response.StatusCode -eq 403) {
                    Write-Error "Unauthorized error returned from $uri, please verify API Key is correct, has access then try again"
                } else {
                    Write-Error "Error calling $uri $($_.Exception.Message) StatusCode: $($_.Exception.Response)"
                }
                throw $_.Exception
            }
        }
    }
}