param(
    [string] $buildVersion
)

$workDir = $PSScriptRoot
$buildPrefix = "$workDir\$buildVersion"

$currentDir = Get-Location

# 编译
Set-Location "$buildPrefix\CPP\7zip\UI\Explorer"
& nmake 'PLATFORM=x86'

Set-Location $currentDir
