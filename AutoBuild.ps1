param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildVersion
)

$workDir = $PSScriptRoot

# 下载源代码并替换资源文件
& "$workDir\Prepare.ps1" $buildVersion -ErrorAction Stop

# 自动查找Visual Studio工具链并进行编译
& "$workDir\Build.ps1" $buildVersion -ErrorAction Stop

# 导出编译好的文件并制作安装包
& "$workDir\Package.ps1" $buildVersion -ErrorAction Stop
