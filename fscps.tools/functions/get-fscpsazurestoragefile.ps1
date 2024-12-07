
<#
    .SYNOPSIS
        Get a file from Azure
        
    .DESCRIPTION
        Get all files from an Azure Storage Account
        
    .PARAMETER AccountId
        Storage Account Name / Storage Account Id where you want to look for files
        
    .PARAMETER AccessToken
        The token that has the needed permissions for the search action
        
    .PARAMETER SAS
        The SAS key that you have created for the storage account or blob container
        
    .PARAMETER DestinationPath
        The destination folder of the Azure file to download. If enpty just show the info
        
    .PARAMETER Container
        Name of the blob container inside the storage account you want to look for files
        
    .PARAMETER Name
        Name of the file you are looking for
        
        Accepts wildcards for searching. E.g. -Name "Application*Adaptor"
        
        Default value is "*" which will search for all packages
        
    .PARAMETER Latest
        Instruct the cmdlet to only fetch the latest file from the Azure Storage Account
        
        Latest nugets parameter
        
    .EXAMPLE
        PS C:\> Get-FSCPSAzureStorageFile -AccountId "miscfiles" -AccessToken "xx508xx63817x752xx74004x30705xx92x58349x5x78f5xx34xxxxx51" -Container "backupfiles"
        
        This will get all files in the blob container "backupfiles".
        It will use the AccessToken "xx508xx63817x752xx74004x30705xx92x58349x5x78f5xx34xxxxx51" to gain access.
        
    .EXAMPLE
        PS C:\> Get-FSCPSAzureStorageFile -AccountId "miscfiles" -AccessToken "xx508xx63817x752xx74004x30705xx92x58349x5x78f5xx34xxxxx51" -Container "backupfiles" -Latest
        
        This will get the latest (newest) file from the blob container "backupfiles".
        It will use the AccessToken "xx508xx63817x752xx74004x30705xx92x58349x5x78f5xx34xxxxx51" to gain access to the container.
        
    .EXAMPLE
        PS C:\> Get-FSCPSAzureStorageFile -AccountId "miscfiles" -AccessToken "xx508xx63817x752xx74004x30705xx92x58349x5x78f5xx34xxxxx51" -Container "backupfiles" -Name "*UAT*"
        
        This will get all files in the blob container "backupfiles" that fits the "*UAT*" search value.
        It will use the AccessToken "xx508xx63817x752xx74004x30705xx92x58349x5x78f5xx34xxxxx51" to gain access to the container.
        
    .EXAMPLE
        PS C:\> Get-FSCPSAzureStorageFile -AccountId "miscfiles" -SAS "sv2018-03-28&siunlisted&src&sigAUOpdsfpoWE976ASDhfjkasdf(5678sdfhk" -Container "backupfiles" -Latest
        
        This will get the latest (newest) file from the blob container "backupfiles".
        It will use the SAS key "sv2018-03-28&siunlisted&src&sigAUOpdsfpoWE976ASDhfjkasdf(5678sdfhk" to gain access to the container.
        
    .NOTES
        Tags: Azure, Azure Storage, Token, Blob, File, Container
        
        This is refactored function from d365fo.tools
        
        Original Author: Mötz Jensen (@Splaxi)
        Author: Oleksandr Nikolaiev (@onikolaiev)
#>
function Get-FSCPSAzureStorageFile {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [string] $AccountId = $Script:AzureStorageAccountId,

        [string] $AccessToken = $Script:AzureStorageAccessToken,

        [string] $SAS = $Script:AzureStorageSAS,

        [Alias('Blob')]
        [Alias('Blobname')]
        [string] $Container = $Script:AzureStorageContainer,

        [Parameter(ParameterSetName = 'Default')]
        [Alias('FileName')]
        [string] $Name = "*",

        [Parameter(ParameterSetName = 'Default')]
        [string] $DestinationPath = "",

        [Parameter(Mandatory = $true, ParameterSetName = 'Latest')]
        [Alias('GetLatest')]
        [switch] $Latest
    )

    if (([string]::IsNullOrEmpty($AccountId) -eq $true) -or
        ([string]::IsNullOrEmpty($Container)) -or
        (([string]::IsNullOrEmpty($AccessToken)) -and ([string]::IsNullOrEmpty($SAS)))) {
        Write-PSFMessage -Level Host -Message "It seems that you are missing some of the parameters. Please make sure that you either supplied them or have the right configuration saved."
        Stop-PSFFunction -Message "Stopping because of missing parameters"
        return
    }

    Invoke-TimeSignal -Start

    if ([string]::IsNullOrEmpty($SAS)) {
        Write-PSFMessage -Level Verbose -Message "Working against Azure Storage Account with AccessToken"

        $storageContext = New-AzStorageContext -StorageAccountName $AccountId.ToLower() -StorageAccountKey $AccessToken
    }
    else {
        Write-PSFMessage -Level Verbose -Message "Working against Azure Storage Account with SAS"

        $conString = $("BlobEndpoint=https://{0}.blob.core.windows.net/;QueueEndpoint=https://{0}.queue.core.windows.net/;FileEndpoint=https://{0}.file.core.windows.net/;TableEndpoint=https://{0}.table.core.windows.net/;SharedAccessSignature={1}" -f $AccountId.ToLower(), $SAS)
        $storageContext = New-AzStorageContext -ConnectionString $conString
    }

    try {
        $files = Get-AzStorageBlob -Container $($Container.ToLower()) -Context $storageContext | Sort-Object -Descending { $_.LastModified }

        if ($Latest) {
            $files | Select-Object -First 1 | Select-PSFObject -TypeName FSCPS.TOOLS.Azure.Blob "name", @{Name = "Size"; Expression = { [PSFSize]$_.Length } }, @{Name = "LastModified"; Expression = { $_.LastModified.UtcDateTime } }
        }
        else {
    
            foreach ($obj in $files) {
                if ($obj.Name -NotLike $Name) { continue }

                if($DestinationPath)
                {
                    $null = Test-PathExists -Path $DestinationPath -Type Container -Create
                    $destinationBlobPath = (Join-Path $DestinationPath ($obj.Name))
                    Get-AzStorageBlobContent -Context $storageContext -Container $($Container.ToLower()) -Blob $obj.Name -Destination ($destinationBlobPath) -ConcurrentTaskCount 10 -Force
                    $obj | Select-PSFObject -TypeName FSCPS.TOOLS.Azure.Blob "name", @{Name = "Size"; Expression = { [PSFSize]$_.Length } }, @{Name = "Path"; Expression = { [string]$destinationBlobPath } }, @{Name = "LastModified"; Expression = { $_.LastModified.UtcDateTime } }
                }
                else
                {
                    $obj | Select-PSFObject -TypeName FSCPS.TOOLS.Azure.Blob "name", @{Name = "Size"; Expression = { [PSFSize]$_.Length } }, @{Name = "LastModified"; Expression = { $_.LastModified.UtcDateTime } }
                }
                
                
            }
        }
    }
    catch {
        Write-PSFMessage -Level Warning -Message "Something broke" -ErrorRecord $_
    }
}