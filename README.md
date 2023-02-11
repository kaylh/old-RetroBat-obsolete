<h1 align="left">
  <br>
  <a href="https://www.retrobat.org/"><img src="https://raw.githubusercontent.com/kaylh/RetroBat/master/system/resources/retrobat_logo.svg" alt="retrobat" width="500"></a>
</h1>
<p align="left">
  <a href="https://discord.gg/k8mg99cY6F">
      <img src="https://img.shields.io/discord/748519802255179917?color=blue&label=discord&logo=discord&logoColor=white&style=for-the-badge"
           alt="Discord">
    </a>
</p>

RetroBat is designed to automatically configure EmulationStation’s frontend interface with RetroArch and other stand alone emulators.

With it you will be able to quickly run games from many compatible ROM collections. This saves hours of configuration and installation time, leaving you free to play your favourite retro games.

RetroBat automatically downloads and installs all the relevant software needed to have the best retro gaming experience on your Windows PC.

RetroBat can also run in Portable Mode. This means you can play games from an external hard drive or from any removable storage device, as long as the computer meets the minimum requirements.

## 💻 System Requirements

|**OS supported:**|Windows 11, Windows 10, Windows 8.1|
|---|---|
|**Processor:**|CPU with SSE2 support. 3 GHz and Dual Core, not older than 2008 is highly recommended.|
|**Graphics:**|Modern graphics card that supports Direct3D 11.1 / OpenGL 4.4 / Vulkan|
|**Dependancies:**|[Visual C++ 2010 Redistributable Packages (32 bit)](https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/)|
|   |[Visual C++ 2015, 2017 and 2019 Redistributable Packages (32 bit)](https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/)|
|   |[Visual C++ 2015, 2017 and 2019 Redistributable Packages (64 bit)](https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/)|
|   |[DirectX](https://www.microsoft.com/download/details.aspx?id=35)|
|**Controllers:**|Xinput controllers hightly recommanded. Test your controller [HERE](https://gamepad-tester.com)|

## 🎮 Supported Machines

![Supported Machines](https://raw.githubusercontent.com/kaylh/RetroBat/master/system/resources/marques.png)

**RetroBat will never provide copyrighted/commercial ROMs or BIOS files.**

## 🧰 Build Instructions

<!--<img src="https://www.retrobat.ovh/img/under-construction.png" width="240" alt="under-construction" class="center">-->

The batch script `build.bat` will download all the softwares required, set the config files and build the RetroBat Setup from `setup.nsi` sources script.

- Download and install [Git for Windows](https://gitforwindows.org/) (follow default setup settings).

- Open CMD Windows Terminal and run the following commands to clone recursively the RetroBat git with its submodules and run build.bat to launch the build routine:
```
git clone --recursive https://github.com/kaylh/RetroBat.git
```
```
cd RetroBat
build.bat
```
- Once the build process is done, you will find the RetroBat Setup in the build directory.

## 🦇 RetroBat Team

- Adrien Chalard "Kayl" - creator of the project, developer
- Lorenzolamas - community management, graphics (former active)
- Fabrice Caruso - lead developer, theme creation
- GetUpOr - community, support
- RetroBoy - community, support
- Tartifless - developer, documentation

## 💟 Special Thanks

- [Hel Mic](https://github.com/lehcimcramtrebor/) - for his wonderful themes.
- [Batocera](https://www.batocera.org/) - for their wonderful retrogaming dedicated Operating System.
- [Gitbook](https://www.gitbook.com/) - for supporting our project.

## ⚖ Licence

RetroBat (c) 2017-2023 Adrien Chalard "Kayl" and The RetroBat Team.

RetroBat is a free and open source project. It should not be used for commercial purposes.
It is done by a team of enthusiasts in their free time mainly for fun.

All the code written by the RetroBat Team, unless covered by a licence from an upstream project, is given under the [LGPL v3 licence](https://www.gnu.org/licenses/lgpl-3.0.html).

It is not allowed to sell RetroBat on a pre-installed machine or on any storage devices. RetroBat includes softwares which cannot be associated with any commercial activities.

Shipping RetroBat with additional proprietary and copyrighted content is illegal, strictly forbidden and strongly discouraged by the RetroBat Team.

Otherwise, you can start a new project off RetroBat sources if you follow the same conditions.

Finally, the license which concerns the entire RetroBat project as a work, in particular the written or graphic content broadcast on its various media, is conditioned by the terms of the [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0/).

|<img src="https://www.gnu.org/graphics/gplv3-127x51.png" width="140" alt="gpl3licence" class="center">|<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Cc-by-nc-sa_icon.svg/180px-Cc-by-nc-sa_icon.svg.png" width="140" alt="cclicence" class="center">|
|---|---|

## © Credits

- EmulationStation (C) 2014 Alec Lofquist, contributions from community (MIT Licence).
- Carbon Theme (c) Fabrice Caruso (CC BY-NC-SA Licence). Originally based on the work of Eric Hettervik (Original Carbon Theme) and Nils Bonenberger (Simple Theme).
- WiimoteGun (c) Fabrice Caruso (GPL3 Licence).
- RetroArch by Libretro Team (GPL3 Licence).

## 💬 Social & Support

- Official Website: https://www.retrobat.org/
- Facebook Group: https://social.retrobat.org/facebook
- Wiki: https://wiki.retrobat.org/
- You need help ? You found a bug ? Please visit RetroBat Forum: https://social.retrobat.org/forum
- Join us on our Discord server: https://social.retrobat.org/discord
- <a class="twitter-timeline" href="https://twitter.com/RetroBat_Off?ref_src=twsrc%5Etfw">Tweets by RetroBat_Off</a>
