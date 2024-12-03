param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $BuildVersion
)

$workDir = $PSScriptRoot
$buildDir = "$workDir\$BuildVersion"
$tempDir = "$workDir\Temp"
$packDir = "$tempDir\Pack"
$prebuildDir = "$tempDir\PreBuild"
$outDir = "$tempDir\Out"

if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir
}

if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir
}

if (-not (Test-Path $prebuildDir)) {
    New-Item -ItemType Directory -Path $prebuildDir
}

if (-not (Test-Path $packDir)) {
    New-Item -ItemType Directory -Path $packDir
}

# 拷贝打包文件
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\Bundles\Format7zF\x64\7z.dll"
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\UI\Console\x64\7z.exe"
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\UI\FileManager\x64\7zFM.exe"
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\UI\GUI\x64\7zG.exe"
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\Bundles\SFXWin\x64\7z.sfx"
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\Bundles\SFXCon\x64\7zCon.sfx"
Copy-Item -Destination $outDir -Path "$buildDir\CPP\7zip\UI\Explorer\x64\7-zip.dll"
Copy-Item -Destination "$outDir\7-zip32.dll" -Path "$buildDir\CPP\7zip\UI\Explorer\x86\7-zip.dll"
Copy-Item -Destination "$outDir\Uninstall.exe" -Path "$buildDir\C\Util\7zipUninstall\x64\7zipUninstall.exe"

# 下载并解压预编译包
if (-not (Test-Path "$tempDir\$BuildVersion-pre.7z")) {
    Invoke-WebRequest -Uri "https://7-zip.org/a/$BuildVersion-x64.exe" -OutFile "$tempDir\$BuildVersion-pre.7z"
    & "$outDir\7z.exe" x "$tempDir\$BuildVersion-pre.7z" -o"$prebuildDir"
}

# 拷贝预编译文件
Copy-Item -Destination $outDir -Path "$prebuildDir\History.txt"
Copy-Item -Destination $outDir -Path "$prebuildDir\License.txt"
Copy-Item -Destination $outDir -Path "$prebuildDir\readme.txt"
Copy-Item -Destination $outDir -Path "$prebuildDir\7-zip.chm"
Copy-Item -Destination $outDir -Path "$prebuildDir\descript.ion"
if (-not (Test-Path "$outDir\Lang")) {
    New-Item -ItemType Directory -Path "$outDir\Lang"
}
Copy-Item -Recurse -Force -Destination "$outDir\Lang" -Path "$prebuildDir\Lang\*"

# 拷贝打包工具
Copy-Item -Recurse -Force -Destination $packDir -Path "$outDir\*"
Copy-Item -Destination "$packDir\7z.sfx" -Path "$buildDir\C\Util\7zipInstall\x64\7zipInstall.exe"
Copy-Item -Destination "$packDir\7zCon.sfx" -Path "$buildDir\C\Util\7zipInstall\x64\7zipInstall.exe"

# 打包
& "$packDir\7z.exe" a -sfx -t7z -mx=9 -m0=LZMA -r "$workDir\$BuildVersion.exe" "$outDir\*"
