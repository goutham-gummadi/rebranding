﻿# Define the path to the CSV file and the log file
$CSVFilePath = ""
$LogFile = ""
#Importing CSV file
$MS365Data= Import-Csv -Path $CSVFilePath 
#Creating a file to track if the changes are successful or not
$ChangeValidation=@()
Foreach($MS365group in $MS365Data)
    {
    $DisplayName = $MS365Data.DisplayName
    $EmailAddress = $MS365group.EmailAddress
    $OldPrimarySMTP= $MS365group.PrimarySMTP
    #Getting Distribution list information
    $MS365groupInfo= Get-UnifiedGroup -Identity $EmailAddress
    if($MS365groupInfo)
        {
        #Creating new Primary SMTP Address
        $NewPrimarySMTP= $EmailAddress.replace("")

#Actual code     
        Set-UnifiedGroup -Identity $EmailAddress -PrimarySmtpAddress $NewPrimarySMTP

        #Checking if the changes are made or not.
        $NewMS365groupInfo= Get-UnifiedGroup -Identity $NewPrimarySMTP 
        if($NewMS365groupInfo)
            {
            if($NewMS365groupInfo.PrimarySmtpAddress -eq $NewPrimarySMTP)
                {
                $ChangeStatus = "Success"
                $LogPrimarySMTP= $NewPrimarySMTP
                }
            else
                {
                $ChangeStatus = "Failed"
                $LogPrimarySMTP= "SMTP not changed"
                }
            }
        else
            {
            $ChangeStatus = "New Distro Not found"
            $LogPrimarySMTP = "New Distro Not found"
            }
        }
    else
        {
        $ChangeStatus = "Old Distro Not found"
        $LogPrimarySMTP = "New Distro Not found"
        }

        $ChangeValidation+=[PSCustomObject]@{
        DisplayName = $DisplayName
        OldPrimarySMTP = ($OldPrimarySMTP -join ",")
        NewPrimarySMTP = ($LogPrimarySMTP -join ",")
        ChangeStatus = $ChangeStatus
        }

    }

    $ChangeValidation | Export-Csv -Path $LogFile -NoTypeInformation -Encoding UTF8
