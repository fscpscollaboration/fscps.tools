#
# Module manifest for module 'fscps.tools'
#
# Generated by: Oleksandr Nikolaiev
#
# Generated on: 6/7/2024
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'fscps.tools.psm1'

# Version number of this module.
ModuleVersion = '1.0.225'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '6b3d02bf-e176-4052-9b40-5012339c20b3'

# Author of this module
Author = 'Oleksandr Nikolaiev'

# Company or vendor of this module
CompanyName = 'Ciellos Inc.'

# Copyright statement for this module
Copyright = 'Copyright (c) 2024 Oleksandr Nikolaiev. All rights reserved.'

# Description of the functionality provided by this module
Description = 'fscps.tools'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName = 'PSFramework'; ModuleVersion = '1.0.12'; }, 
               @{ModuleName = 'Az.Storage'; ModuleVersion = '1.11.0'; }, 
               @{ModuleName = 'd365fo.tools'; ModuleVersion = '0.7.11'; }, 
               @{ModuleName = 'Invoke-MsBuild'; ModuleVersion = '2.7.1'; })

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = 'bin\fscps.tools.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'xml\fscps.tools.Format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Get-FSCPSSettings', 
    'Set-FSCPSSettings', 
    'Invoke-FSCPSChoco', 
    'Get-FSCPSNuget', 
    'Get-FSCPSVersionInfo', 
    'Invoke-FSCPSCompile', 
    'Install-FSCPSNugetCLI', 
    'Find-FSCPSCommand', 
    'Disable-FSCPSException',
    'Enable-FSCPSException', 
    'Get-FSCPSAzureStorageFile',
    'Update-FSCPSModelVersion', 
    'Invoke-FSCPSDigiCertSignFile', 
    'Invoke-FSCPSAzureSignToolSignFile', 
    'Add-FSCPSAzureStorageConfig', 
    'Get-FSCPSAzureStorageConfig', 
    'Get-FSCPSActiveAzureStorageConfig', 
    'Register-FSCPSAzureStorageConfig', 
    'Set-FSCPSActiveAzureStorageConfig', 
    'Invoke-FSCPSAzureStorageDownload', 
    'Invoke-FSCPSAzureStorageUpload', 
    'Invoke-FSCPSAzureStorageDelete', 
    'Update-FSCPSISVSource'
)
# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'd365fo','d365fsc','Dynamics365','D365','Finance&Operations','FinanceOperations','FinanceAndOperations','Dynamics365FO','fscps','fsc-ps'

        # A URL to the license for this module.
        LicenseUri = 'https://opensource.org/licenses/apache-2-0'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/fscpscollaborative/fscps.tools'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/fscpscollaborative/fscps.tools/master/images/fscps-logo.png'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        ExternalModuleDependencies = @('PSDiagnostics')

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}