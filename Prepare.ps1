param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildVersion
)

$workDir = $PSScriptRoot
$tempDir = "$workDir\Temp"
$resDir = "$workDir\Resources"
$buildDir = "$workDir\$buildVersion"

if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir
}

# 下载7zR
if (-not (Test-Path "$tempDir\7zr.exe")) {
    Invoke-WebRequest -Uri "https://www.7-zip.org/a/7zr.exe" -OutFile "$tempDir\7zr.exe"
}

# 下载并解压源码
if (-not (Test-Path $buildDir)) {
    if (-not (Test-Path "$tempDir\$buildVersion-src.7z")) {
        Invoke-WebRequest -Uri "https://7-zip.org/a/$buildVersion-src.7z" -OutFile "$tempDir\$buildVersion-src.7z"
    }
    & "$tempDir\7zr.exe" x "$tempDir\$buildVersion-src.7z" -o"$buildDir"
}

# 拷贝图标
Copy-Item -Force -Recurse -Path "$resDir\FileIcons\*.ico" -Destination "$buildDir\CPP\7zip\Archive\Icons"

# 拷贝资源文件
Copy-Item -Force -Path "$resDir\Format7zF.rc" -Destination "$buildDir\CPP\7zip\Bundles\Format7zF\resource.rc"
Copy-Item -Force -Path "$resDir\Fm.rc" -Destination "$buildDir\CPP\7zip\Bundles\Fm\resource.rc"

# 拷贝UI图
Copy-Item -Force -Path "$resDir\ToolBarIcons\*.bmp" -Destination "$buildDir\CPP\7zip\UI\FileManager"
