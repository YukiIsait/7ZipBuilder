param(
    [string] $buildVersion
)

$workDir = $PSScriptRoot
$resDir = "$workDir\Resources"
$buildPrefix = "$workDir\$buildVersion"

# 下载7zR
if (-not (Test-Path "$workDir\7zR.exe")) {
    [System.Net.WebClient]::new().DownloadFile("https://www.7-zip.org/a/7zr.exe", "$workDir\7zR.exe")
}

# 下载并解压源码
if (-not (Test-Path "$buildPrefix.7z")) {
    [System.Net.WebClient]::new().DownloadFile("https://7-zip.org/a/$buildVersion-src.7z", "$buildPrefix.7z")
    & "$workDir\7zr.exe" x "$buildPrefix.7z" -o"$buildPrefix"
}

# 拷贝图标
Copy-Item -Force -Recurse -Path "$resDir\FileIcons\*.ico" -Destination "$buildPrefix\CPP\7zip\Archive\Icons"

# 拷贝资源文件
Copy-Item -Force -Path "$resDir\Format7zF.rc" -Destination "$buildPrefix\CPP\7zip\Bundles\Format7zF\resource.rc"
Copy-Item -Force -Path "$resDir\Fm.rc" -Destination "$buildPrefix\CPP\7zip\Bundles\Fm\resource.rc"

# 拷贝UI图
Copy-Item -Force -Path "$resDir\ToolBarIcons\*.bmp" -Destination "$buildPrefix\CPP\7zip\UI\FileManager"
