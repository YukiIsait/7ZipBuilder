param(
    [string] $buildVersion
)

$buildPrefix = "$PSScriptRoot\$buildVersion"
$workDir = $PSScriptRoot
$packDir = "$workDir\7zPack"
$prebuildPrefix = "$workDir\7zPreBuild"
$outPrefix = "$workDir\7zOut"

if (-not (Test-Path $outPrefix)) {
    New-Item -ItemType Directory -Path $outPrefix
}

if (-not (Test-Path $prebuildPrefix)) {
    New-Item -ItemType Directory -Path $prebuildPrefix
}

if (-not (Test-Path $packDir)) {
    New-Item -ItemType Directory -Path $packDir
}

# 拷贝打包文件
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\Bundles\Format7zF\x64\7z.dll"
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\UI\Console\x64\7z.exe"
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\UI\FileManager\x64\7zFM.exe"
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\UI\GUI\x64\7zG.exe"
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\Bundles\SFXWin\x64\7z.sfx"
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\Bundles\SFXCon\x64\7zCon.sfx"
Copy-Item -Destination $outPrefix -Path "$buildPrefix\CPP\7zip\UI\Explorer\x64\7-zip.dll"
Copy-Item -Destination "$outPrefix\7-zip32.dll" -Path "$buildPrefix\CPP\7zip\UI\Explorer\x86\7-zip.dll"
Copy-Item -Destination "$outPrefix\Uninstall.exe" -Path "$buildPrefix\C\Util\7zipUninstall\x64\7zipUninstall.exe"

# 下载并解压预编译包
if (-not (Test-Path "$prebuildPrefix\$buildVersion.7z")) {
    [System.Net.WebClient]::new().DownloadFile("https://7-zip.org/a/$buildVersion-x64.exe", "$prebuildPrefix\$buildVersion.7z")
    & "$outPrefix\7z.exe" x "$prebuildPrefix\$buildVersion.7z" -o"$prebuildPrefix"
}

# 拷贝预编译文件
Copy-Item -Destination $outPrefix -Path "$prebuildPrefix\History.txt"
Copy-Item -Destination $outPrefix -Path "$prebuildPrefix\License.txt"
Copy-Item -Destination $outPrefix -Path "$prebuildPrefix\readme.txt"
Copy-Item -Destination $outPrefix -Path "$prebuildPrefix\7-zip.chm"
Copy-Item -Destination $outPrefix -Path "$prebuildPrefix\descript.ion"
if (-not (Test-Path "$outPrefix\Lang")) {
    New-Item -ItemType Directory -Path "$outPrefix\Lang"
}
Copy-Item -Recurse -Force -Destination "$outPrefix\Lang" -Path "$prebuildPrefix\Lang\*"

# 拷贝打包工具
Copy-Item -Recurse -Force -Destination $packDir -Path "$outPrefix\*"
Copy-Item -Destination "$packDir\7z.sfx" -Path "$buildPrefix\C\Util\7zipInstall\x64\7zipInstall.exe"
Copy-Item -Destination "$packDir\7zCon.sfx" -Path "$buildPrefix\C\Util\7zipInstall\x64\7zipInstall.exe"

# 打包
& "$packDir\7z.exe" a -sfx -t7z -mx=9 -m0=LZMA -r "$workDir\$buildVersion.exe" "$outPrefix\*"
