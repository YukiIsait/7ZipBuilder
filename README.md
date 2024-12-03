# 7-Zip 自动编译脚本

🌍 **[English](README-EN.md) | [简体中文](README.md)**

[7-Zip](https://www.7-zip.org/) 的自动编译脚本，用于更简便的从源代码定制它。

## 使用方法

### 本机编译

> - 使用 PowerShell 执行 `.ps1` 需要开启相应权限，本文不进行赘述。
> - 编译需要 **Visual Studio** 并已安装**使用 C++ 的桌面开发**组件。
> - 以下过程以 `7z2409` 版本为例。

1. 自动构建：

    ```pwsh
    .\AutoBuild.ps1 7z2409
    ```

2. 检查生成的安装包 **7z2409.exe** 是否可用。

### 在线编译

> 在线编译可以极大地简化编译流程，无需安装任何软件。

1. Fork 本仓库。
2. 在 **Actions** 选项中选择 **Build** 项。
3. 点击 **Run workflow** 开始编译。
4. 编译完成后在 **Artifacts** 中下载 **7-Zip Installer**。
5. 检查生成的安装包 **7z2409.exe** 是否可用。

## 自定义

> 更详细的使用方法见 [更现代的 7-Zip](https://123) 项目。

在自动编译脚本的同目录下创建 `SubPrepare.ps1` 并接收两个参数，可用于在脚本准备好源代码时调用自定义流程，例如用自定义的图标替换掉原始图标：

```pwsh
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildDirectory,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildVersion
)

Copy-Item -Force -Recurse -Path "FileIcons\*.ico" -Destination "$buildDirectory\CPP\7zip\Archive\Icons"
```

## 开源许可

- 本项目采用 MIT 许可证，详见[许可文件](LICENSE.md)。
- 7-Zip 项目采用 GNU LGPL、BSD 3 以及 unRAR 许可证，详见[许可文件](https://www.7-zip.org/license.txt)。
