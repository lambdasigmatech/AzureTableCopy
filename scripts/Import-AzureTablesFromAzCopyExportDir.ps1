<#	
	.SYNOPSIS
		The Import-AzureTablesFromAzCopyExportDir.ps1 is used to import files created from an AzCopy.exe export.
		The export files from AzCopy are all contained in a single directory by default.
		
		
	.DESCRIPTION
		The Import-AzureTablesFromAzCopyExportDir.ps1 will import all of the Azure Tables
		and data from a directory which has all of the files created from an 
		AzCopy.exe Azure Tables export.  It will infer the names of the Azure Tables from
		the .manifest file names using a Regular Expression.  If the Azure Table Names are
		not able to be inferred, the RegEx pattern for -match may need to be updated.

	.PARAMETER <AzCopyExePath>
	.PARAMETER <AzCopyExportDir>
	.PARAMETER <DestinationTableStorageURL>
	.PARAMETER <DestinationStorageAccountKey>

	.INPUTS
		The following Parameters are Mandatory Inputs for the Import-AzureTablesFromAzCopyExportDir.ps1 script:

		1. AzCopyExePath - this is the local path for the AzCopy.exe tool
			Default Install AzCopy Path: 'C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe'
		2. AzCopyExportDir - this is the directory that contains exported files
			Example AzCopy Export Dir: 'C:\PowerShellScripts\AzCopy\ExportedFiles'
		3. DestinationTableStorageURL - this is the URL for Azure Table storage
			Example Destination Table Storage URL string: 'https://storageaccountname.table.core.windows.net'
		4. DestinationStorageAccountKey - this is the Key for the Azure Storage account
			This Key comes from the Storage Account Access Keys

	.OUTPUTS
		The default script output is the AzCopy.exe output as it Imports the Azure Tables and data.

	.NOTES
	=====================================================================================
	 Created on:	
	 Created by:	
	 Filename:	Import-AzureTablesFromAzCopyExportDir.ps1     	
	=====================================================================================
		
#>

# List of Input Parameters required to Import the Azure Tables using AzCopy.exe
param (
	
	[Parameter(Mandatory=$true)]
	[string]$AzCopyExePath,
	
	[Parameter(Mandatory = $true)]
	[string]$AzCopyExportDir,
	
	[Parameter(Mandatory = $true)]
	[string]$DestinationTableStorageURL,
	
	[Parameter(Mandatory = $true)]
	[string]$DestinationStorageAccountKey
	
)


# Get all of the manifest files in the export directory
$exportedManifestFiles = Get-ChildItem $AzCopyExportDir -Recurse -Include '*.manifest'

Write-Host "Importing all Azure tables that were exported from the .csv file Azure table list..."
foreach ($file in $exportedManifestFiles)
{
	# Create the AzCopy Source argument
	$sourceArg = "/Source:" + $AzCopyExportDir
	
	# Get the .manifest file name and extract the table name substring
	$manifestFileName = $file.Name
	# Find table name substring from AzCopy manifest file using regex 
	# Underscore ASCII Hex Value = 5F
	$manifestFileName -match '\x5F{1}[a-z][A-Z]+\x5F{1}' | Out-Null
	# $Matches[] array contains matching strings 
	$regExSubStringMatch = $Matches[0].ToString()
	# Get Azure table name from between underscore chars 
	$regExSubStringMatch = $regExSubStringMatch.Substring(1, ($regExSubStringMatch.Length - 2))
		
	# Create the AzCopy Dest argument
	$destArg = "/Dest:" + $DestinationTableStorageURL + $regExSubStringMatch
	
	# Create the AzCopy Manifest argument
	$manifestArg = "/Manifest:" + $file.Name
	
	# Create the DestKey argument
	$destKeyArg = "/DestKey:" + $DestinationStorageAccountKey
	
	# Create the EntityOperation argument
	$entityOperationArg = "/EntityOperation:InsertOrReplace"
	
	# Build import arguments list to pass to AzCopy.exe
	$azCopyImportAllArgs = ($sourceArg, $destArg, $manifestArg, $destKeyArg, $entityOperationArg)
	
	# Call AzCopy.exe with arguments list
	& $AzCopyExePath $azCopyImportAllArgs
	
	
}

