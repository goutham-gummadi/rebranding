# Define the path to the CSV file and the log file
$CSVFilePath = ""
$LogFile = ""
#Importing CSV file
$DistroData= Import-Csv -Path $CSVFilePath 
#Creating a file to track if the changes are successful or not
$RollOverValidation=@()
Foreach($Distro in $DistroData)
    {
    $EmailAddress = $Distro.EmailAddress
    $OldPrimarySMTP= $Distro.PrimarySMTP
    #Getting Distribution list information
    $DistributionInfo= Get-DistributionGroup -Identity $EmailAddress
    if($DistributionInfo)
        {
         $NewPrimarySMTP= $EmailAddress.replace("")
         
#Actual code     
        Set-DistributionGroup -Identity $EmailAddress -PrimarySmtpAddress $OldPrimarySMTP

        #Checking if the changes are made or not.
        $OldDistributionInfo= Get-DistributionGroup -Identity $EmailAddress 
        if($OldDistributionInfo)
            {
            if($DistributionInfo.PrimarySmtpAddress -eq $OldPrimarySMTP)
                {
                $RollOverStatus = "Passed"
                $LogPrimarySMTP= $OldDistributionInfo.PrimarySmtpAddress
                }
            else
                {
                $RollOverStatus = "Failed"
                $LogPrimarySMTP= "Failed to roll over"
                }
            }
        else
            {
            $ChangeStatus = " Distro Not found"
            $LogPrimarySMTP = "Distro Not found"
            }
        }
    else
        {
        $RollOverStatus = "Old Distro Not found"
        $LogPrimarySMTP = "Distro Not found"
        }

        $RollOverValidation+=[PSCustomObject]@{
        OldPrimarySMTP = ($OldPrimarySMTP -join ",")
        NewPrimarySMTP = ($LogPrimarySMTP -join ",")
        RollOverStatus = $RollOverStatus
        }

    }

    $RollOverValidation | Export-Csv -Path $LogFile -NoTypeInformation -Encoding UTF8
