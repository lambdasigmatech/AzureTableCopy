# AzureTableCopy
This repo contains PowerShell script wrappers for the Microsoft Azure AzCopy.exe tool.  



There are two scripts that wrap AzCopy.exe to Export and Import Azure Tables.
Both PowerShell scripts have full help detail in them.

PowerShell Scripts
1. Export-AzureTablesFromCSV.ps1
2. Import-AzureTablesFromAzCopyExportDir.ps1

There is an input file which is a single column .csv file.  
This is passed as input to the Export PowerShell script.

Input CSV File
1. AzureTablesToExport.csv

-----------------------------------------------------------------------------------------------------------------------

PowerShell Script Help - Run the following from a PowerShell console window

Get-Help -Full .\Export-AzureTablesFromCSV.ps1
< Console Output >

NAME
    C:\PowerShellScripts\Azure\Export-AzureTablesFromCSV.ps1

SYNOPSIS


SYNTAX
    C:\PowerShellScripts\Azure\Export-AzureTablesFromCSV.ps1 [-AzCopyExePath] <String> [-AzCopyExportDir] <String>
    [-SourceTableStorageURL] <String> [-SourceStorageAccountKey] <String> [-CSVFilePath] <String> [<CommonParameters>]


DESCRIPTION
    Get a csv input file with a list of Azure Tables and export them using
    AzCopy.exe to an export directory.


PARAMETERS
    -AzCopyExePath <String>

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -AzCopyExportDir <String>

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -SourceTableStorageURL <String>

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -SourceStorageAccountKey <String>

        Required?                    true
        Position?                    4
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -CSVFilePath <String>

        Required?                    true
        Position?                    5
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

INPUTS
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


OUTPUTS



NOTES


        =====================================================================================
         Created on:
         Created by:
         Filename:      Export-AzureTablesFromCSV.ps1
        =====================================================================================


RELATED LINKS

-----------------------------------------------------------------------------------------------------------------------

Get-Help -Full .\Import-AzureTablesFromAzCopyExportDir.ps1
< Console Output >

NAME
    C:\PowerShellScripts\Azure\Import-AzureTablesFromAzCopyExportDir.ps1

SYNOPSIS
    The Import-AzureTablesFromAzCopyExportDir.ps1 is used to import files created from an AzCopy.exe export.
    The export files from AzCopy are all contained in a single directory by default.


SYNTAX
    C:\PowerShellScripts\Azure\Import-AzureTablesFromAzCopyExportDir.ps1 [-AzCopyExePath] <String> [-AzCopyExportDir]
    <String> [-DestinationTableStorageURL] <String> [-DestinationStorageAccountKey] <String> [<CommonParameters>]


DESCRIPTION
    The Import-AzureTablesFromAzCopyExportDir.ps1 will import all of the Azure Tables
    and data from a directory which has all of the files created from an
    AzCopy.exe Azure Tables export.  It will infer the names of the Azure Tables from
    the .manifest file names using a Regular Expression.  If the Azure Table Names are
    not able to be inferred, the RegEx pattern for -match may need to be updated.


PARAMETERS
    -AzCopyExePath <String>

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -AzCopyExportDir <String>

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -DestinationTableStorageURL <String>

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -DestinationStorageAccountKey <String>

        Required?                    true
        Position?                    4
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

INPUTS
    The following Parameters are Mandatory Inputs for the Import-AzureTablesFromAzCopyExportDir.ps1 script:

    1. AzCopyExePath - this is the local path for the AzCopy.exe tool
        Default Install AzCopy Path: 'C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe'
    2. AzCopyExportDir - this is the directory that contains exported files
        Example AzCopy Export Dir: 'C:\PowerShellScripts\AzCopy\ExportedFiles'
    3. DestinationTableStorageURL - this is the URL for Azure Table storage
        Example Destination Table Storage URL string: 'https://storageaccountname.table.core.windows.net'
    4. DestinationStorageAccountKey - this is the Key for the Azure Storage account
        This Key comes from the Storage Account Access Keys


OUTPUTS
    The default script output is the AzCopy.exe output as it Imports the Azure Tables and data.


NOTES


        =====================================================================================
         Created on:
         Created by:
         Filename:      Import-AzureTablesFromAzCopyExportDir.ps1
        =====================================================================================


RELATED LINKS

-----------------------------------------------------------------------------------------------------------------------