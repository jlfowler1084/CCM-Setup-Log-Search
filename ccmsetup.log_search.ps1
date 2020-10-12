$ErrorActionPreference = 'silentlyContinue'
$Servers = import-csv 'csv file location' | Select-Object name -ExpandProperty name

foreach ($Server in $Servers) { 

    $ClientInstallLog = "\\$Server\C$\Windows\ccmsetup\logs\ccmsetup.log"

    if (Test-Path $ClientInstallLog){
        $LogContent = Get-Content -Path  $ClientInstallLog | Select-Object -last 1
            if ($LogContent -match "CcmSetup is exiting with return code 0" ) 
                { 
                    write-host $Server $LogContent -ForegroundColor green
                }
            else
                { 
                    write-host $Server $LogContent -ForegroundColor Red 
                }
            } 
    else 
        { 
            write-host "ccmsetup.log not detected on $Server" 
        }
     }
