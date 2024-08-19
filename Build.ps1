param(
    [string] $buildVersion
)

$workDir = $PSScriptRoot
$buildPrefix = "$workDir\$buildVersion"

$currentDir = Get-Location

# 编译
Set-Location "$buildPrefix\CPP\7zip"
& nmake 'PLATFORM=x64'
Set-Location "$buildPrefix\C\Util\7zipInstall"
& nmake 'PLATFORM=x64'
Set-Location "$buildPrefix\C\Util\7zipUninstall"
& nmake 'PLATFORM=x64'

Set-Location $currentDir
