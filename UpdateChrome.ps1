$VersionCheck = Get-WmiObject -Class Win32_Product | where name -eq 'google chrome' | select Version
Write-Host "Current version:" $VersionCheck
If ($VersionCheck -le 99.0.4844.84){
    
    ## If Winget is working
    $WingetInstalled = Get-AppxPackage | Select-Object -Property name | findstr "Microsoft.Winget.Source"
    If ($WingetInstalled -eq "Microsoft.Winget.Source") {
        Write-Host "Winget Is installed, Updating now..."
        winget upgrade -h chrome
        taskkill /F /IM chrome.exe
    } else {
        Write-Host "Winget is not installed, using MSIExec"
        Invoke-WebRequest -URi "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi" -OutFile "C:\temp\UpgradeChrome.msi"
        C:\temp\UpgradeChrome.msi /qn
        taskkill /F /IM chrome.exe
        $NewVersion = Get-WmiObject -Class Win32_Product | where name -eq 'google chrome' | select Version
        Write-Host $NewVersion
    }
} Else {
    Write-host "Chrome is Updated"
}
