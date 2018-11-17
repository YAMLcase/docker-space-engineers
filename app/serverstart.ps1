$appid = "298740"

# Download latest version of SteamCMD
$(steamcmd.exe +login anonymous +quit; powershell exit 0)

# Download latest version of Space Engineers Dedicated Server
$(steamcmd.exe +login anonymous +force_install_dir C:/server/ +app_update $appid +quit; powershell exit 0)

# Start the server
$oldlogs = gci C:\data\*.log # getting list of old log files to ignore
C:\server\DedicatedServer64\SpaceEngineersDedicated.exe -noconsole -path c:\data

# Dedicated Server console opens in a separate instance, therefore we need to just tail the latest
# log file.

Write-Host -NoNewline "Waiting for server to start."
DO
{
  Write-Host -NoNewline "."
  $newlogs = gci C:\data\*.log
  $logFileCompare = Compare-Object -ReferenceObject $oldlogs -DifferenceObject $newlogs
  Start-Sleep -m 300
} Until ($logFileCompare)
Write-Host "Started."

$logfile = $logFileCompare.InputObject
Get-Content -Path $logfile -Wait

# If you see top-like output, something went wrong with the log tail
While(1) {ps | sort -des cpu | select -f 15 | ft -a; sleep 1; cls}
