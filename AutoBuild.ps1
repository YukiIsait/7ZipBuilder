param(
    [string] $buildVersion
)

$workDir = $PSScriptRoot

& "$workDir\Prepare.ps1" $buildVersion
& "$workDir\Build.ps1" $buildVersion
& "$workDir\Pack.ps1" $buildVersion
