param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildVersion
)

$workDir = $PSScriptRoot
$buildDir = "$workDir\$buildVersion"
$tempDir = "$workDir\Temp"

$currentDir = Get-Location

if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir
}

# 下载并解压VsWhere
if (-not (Test-Path "$tempDir\VsWhere")) {
    if (-not (Test-Path "$tempDir\vswhere.zip")) {
        [System.Net.WebClient]::new().DownloadFile("https://www.nuget.org/api/v2/package/vswhere", "$tempDir\vswhere.zip")
    }
    [System.IO.Compression.ZipFile]::ExtractToDirectory("$tempDir\vswhere.zip", "$tempDir\VsWhere")
}

# 查找并进入x64编译环境
$vsInstallPath = & "$tempDir\VsWhere\tools\vswhere.exe" -latest -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
Import-Module "$vsInstallPath\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell -VsInstallPath $vsInstallPath -DevCmdArguments "-arch=amd64 -host_arch=amd64" -SkipAutomaticLocation

# 编译7-Zip本体及其安装卸载程序
Set-Location "$buildDir\CPP\7zip"
& nmake PLATFORM=x64
Set-Location "$buildDir\C\Util\7zipInstall"
& nmake PLATFORM=x64
Set-Location "$buildDir\C\Util\7zipUninstall"
& nmake PLATFORM=x64

# 进入x86编译环境
Enter-VsDevShell -VsInstallPath $vsInstallPath -DevCmdArguments "-arch=x86 -host_arch=amd64" -SkipAutomaticLocation

# 编译32位Shell拓展
Set-Location "$buildDir\CPP\7zip\UI\Explorer"
& nmake PLATFORM=x86

# 回到原始目录
Set-Location $currentDir
