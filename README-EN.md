# 7-Zip Automatic Compilation Script

🌍 **[简体中文](README.md) | [English](README-EN.md)**

> **The finished product has been separated into an independent repository [More Modern 7-Zip](https://github.com/YukiIsait/MoreModern7Zip).**

An automatic compilation script for [7-Zip](https://www.7-zip.org/), used to customize it more easily from the source code.

## Usage

### Native Compilation

> - To execute `.ps1` scripts with PowerShell requires appropriate permissions, which are not covered here.
> - Compilation requires **Visual Studio** with the **Desktop development with C++** workload installed.
> - The following process uses version `7z2409` as an example.

1. Automatic Build:

    ```pwsh
    .\AutoBuild.ps1 7z2409
    ```

2. Check if the generated installer **7z2409.exe** is functional.

### Online Compilation

> Online compilation can greatly simplify the compilation process, eliminating the need to install any software.

1. Fork this repository.
2. Select the **Build** item in the **Actions** tab.
3. Click **Run workflow** to start the compilation.
4. After the compilation is complete, download the **7-Zip Installer** from the **Artifacts** section.
5. Check if the generated installer **7z2409.exe** is functional.

## Customization

> For more detailed usage, see the [More Modern 7-Zip](https://github.com/YukiIsait/MoreModern7Zip).

Create `SubPrepare.ps1` in the same directory as the automatic compilation script, which accepts two parameters. This can be used to call custom processes when the script prepares the source code, such as replacing the original icons with custom ones:

```pwsh
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildDirectory,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $buildVersion
)

Copy-Item -Force -Recurse -Path "FileIcons\*.ico" -Destination "$buildDirectory\CPP\7zip\Archive\Icons"
```

## License

- This project is licensed under the MIT license. See the [LICENSE](LICENSE.md) file for details.
- The 7-Zip project is licensed under the GNU LGPL, BSD 3, and unRAR licenses. See the [LICENSE](https://www.7-zip.org/license.txt) file for details.
