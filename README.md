# 7-Zip 自动编译脚本

🌍 **[English](README-EN.md) | [简体中文](README.md)**

[7-Zip](https://www.7-zip.org/) 的自动编译脚本，编译的同时为它更换了更漂亮的文件关联图标和文件管理器贴图，并添加了 **Jar** 和 **War** 文件关联（~~夹带私货~~）。

目前更换的文件关联图标和文件管理器贴图均为本人在网上下载自用，暂时未找到作者，如果作者大大看到本仓库可以联系添加作者信息。

## 文件管理器预览

![Preview1](Previews/Preview1.png)

## 文件关联图标预览

![Preview1](Previews/Preview2.png)

## 使用方法

> - 用 PowerShell 执行 `.ps1` 需要开启相应权限，本文不进行赘述。
> - 编译需要 **Visual Studio** 并已安装**使用 C++ 的桌面开发**组件。
> - 以下过程以 `7z2408` 版本为例。

1. 下载源代码并替换资源文件：

    1. 打开 PowerShell。
    2. 执行 `.\Prepare.ps1 7z2408`。

2. 编译 x64 的软件本体：

    1. 打开 Visual Studio 的 x64 开发人员命令提示符，例如 **x64 Native Tools Command Prompt for VS 2022**。
    2. 切换到 PowerShell，如果已安装 PowerShell Core 可输入 `pwsh`，否则应输入 `powershell`。
    3. 执行 `.\Build.ps1 7z2408`。

3. 编译 x86 的 Shell 拓展：

    1. 打开 Visual Studio 的 x86 开发人员命令提示符，例如 **x64_x86 Cross Tools Command Prompt for VS 2022**。
    2. 切换到 PowerShell，如果已安装 PowerShell Core 可输入 `pwsh`，否则应输入 `powershell`。
    3. 执行 `.\BuildShell32.ps1 7z2408`。

4. 打包 7-Zip 并制作安装包：

    1. 打开 PowerShell。
    2. 执行 `.\Pack.ps1 7z2408`。
    3. 检查生成的安装包 **7z2408.exe** 是否可用。

## 开源许可

- 本项目采用 MIT 许可证，详见[许可文件](LICENSE.md)。
- 7-Zip 项目采用 GNU LGPL、BSD 3 以及 unRAR 许可证，详见[许可文件](https://www.7-zip.org/license.txt)。

## 关于我们

- 软件发布：[吾爱破解 &lt;https://www.52pojie.cn/thread-1955841-1-1.html&gt;](https://www.52pojie.cn/thread-1955841-1-1.html)
- 官方网站：[雨糖科技 &lt;https://raincandy.tech&gt;](https://raincandy.tech)
