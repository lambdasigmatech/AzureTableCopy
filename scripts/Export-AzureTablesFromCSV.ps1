<#	
	.SYNOPSIS

	.DESCRIPTION
		Get a csv input file with a list of Azure Tables and export them using
		AzCopy.exe to an export directory.

	.PARAMETER <AzCopyExePath>
	.PARAMETER <AzCopyExportDir>
	.PARAMETER <SourceTableStorageURL>
	.PARAMETER <SourceStorageAccountKey>
	.PARAMETER <CSVFilePath>
	
	.INPUTS
		The following Parameters are Mandatory Inputs for the Export-AzureTablesFromCSV.ps1 script:

		1. AzCopyExePath - this is the local path for the AzCopy.exe tool
			Default Install AzCopy Path: 'C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe'
		2. AzCopyExportDir - this is the directory that will received the exported files created by AzCopy.exe
			Example AzCopy Export Dir: 'C:\PowerShellScripts\AzCopy\ExportedFiles'
		3. SourceTableStorageURL - this is the URL for Azure Table storage
			Example Source Table Storage URL string: 'https://storageaccountname.table.core.windows.net/'
		4. DestinationStorageAccountKey - this is the Key for the Azure Storage account
			This Key comes from the Storage Account Access Keys
		5. CSVFilePath - this is the path to the .csv file with a list of Azure Tables to export.  
			The .csv file should have a header named 'AzureTableName', and then a list of tables.
			Example CSVFilePath: 'C:\PowerShellScripts\AzCopy\AzureTablesToExport.csv'
	
	.OUTPUTS
	
	.NOTES
	=====================================================================================
	 Created on:   	
	 Created by:   	
	 Filename:     	Export-AzureTablesFromCSV.ps1
	=====================================================================================
	
#>

# List of Input Parameters required to Export the Azure Tables using AzCopy.exe
param (
	
	[Parameter(Mandatory = $true)]
	[string]$AzCopyExePath,
	[Parameter(Mandatory = $true)]
	[string]$AzCopyExportDir,
	[Parameter(Mandatory = $true)]
	[string]$SourceTableStorageURL,
	[Parameter(Mandatory = $true)]
	[string]$SourceStorageAccountKey,
	[Parameter(Mandatory = $true)]
	[string]$CSVFilePath
	
)

# The input is a .csv file with a single column that has all of the Azure tables to export
# The .csv file should have a header named AzureTableName, and then a column of Azure Table Names
# with 1 row per Azure Table
$azureTableList = Import-Csv $CSVFilePath

Write-Host "Exporting all Azure Tables from the .csv file Azure table list..."

# Loop through the list of Azure tables fromo the .csv input and export them to a local directory
foreach ($table in $azureTableList)
{
	# Create the  Source argument
	$sourceTableToExport = "/Source:" + $SourceTableStorageURL + $table.AzureTableName
	
	# Create the Dest argument
	$destArg = "/Dest:" + $AzCopyExportDir
	
	# Create the SourceKey argument
	$sourceKeyArg = "/SourceKey:" + $SourceStorageAccountKey
	
	# Build export arguments list to pass to AzCopy.exe
	$azCopyExportAllArgs = ($sourceTableToExport, $destArg, $sourceKeyArg)
	
	# Call AzCopy.exe with arguments list
	& $AzCopyExePath $azCopyExportAllArgs
	
}



