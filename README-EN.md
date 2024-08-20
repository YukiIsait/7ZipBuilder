# 7-Zip Automatic Compilation Script

🌍 **[简体中文](README.md) | [English](README-EN.md)**

An automatic compilation script for [7-Zip](https://www.7-zip.org/), which replaces the default file association icons and file manager skins with more attractive ones, and adds associations for Jar and War files.

The file association icons and file manager skins currently used were downloaded online for personal use. If the original authors see this repository, please contact me to add author information.

## File Manager Preview

![Preview1](Previews/Preview1.png)

## File Association Icons Preview

![Preview1](Previews/Preview2.png)

## Usage

> - To execute `.ps1` scripts with PowerShell requires appropriate permissions, which are not covered here.
> - Compilation requires **Visual Studio** with the **Desktop development with C++** workload installed.
> - The following process uses version `7z2408` as an example.

1. Automatic Build:

    ```pwsh
    .\AutoBuild.ps1 7z2408
    ```

2. Check if the generated installer **7z2408.exe** is functional.

## License

- This project is licensed under the MIT license. See the [LICENSE](LICENSE.md) file for details.
- The 7-Zip project is licensed under the GNU LGPL, BSD 3, and unRAR licenses. See the [LICENSE](https://www.7-zip.org/license.txt) file for details.

## About Us

- Release: [52PoJie &lt;https://www.52pojie.cn/thread-1955841-1-1.html&gt;](https://www.52pojie.cn/thread-1955841-1-1.html)
- Website: [RainCandy Tech &lt;https://raincandy.tech&gt;](https://raincandy.tech)
