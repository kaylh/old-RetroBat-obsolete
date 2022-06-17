<img src="https://www.retrobat.ovh/img/retrobat_logo.svg" width="600" alt="RetroBat-Logo" class="center">

## 📌 Presentation

RetroBat is a Windows softwares distribution dedicated to retrogaming and emulation. It provides fully configured EmulationStation frontend with all emulators needed to have the best retrogaming experience on your Windows PC.

With RetroBat you will be quickly able to run your games from a ROMs collection and save your time to play.

RetroBat is designed to be portable. That means you can start it from HDD or from any removable storage device, as long as you do it on a computer that meets the requirements. 

![Discord Shield](https://discordapp.com/api/guilds/748519802255179917/widget.png?style=banner2)

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

![Supported Machines](https://www.retrobat.ovh/img/systems4.png)

**RetroBat will never provide copyrighted/commercial ROMs or BIOS files.**

## 🧰 Build Instructions

<!--<img src="https://www.retrobat.ovh/img/under-construction.png" width="240" alt="under-construction" class="center">-->

If you want to read and build retrobat.mfa sources file you need a legit copy of Fusion 2.5 developper.

Why use proprietary development software like Clickteam Fusion 2.5? 
*Until version 2.1, retrobat consisted mainly of a collection of batch and powershell scripts to facilitate the use and configuration of EmulationStation with RetroArch. I didn't originally have any training in software development, I used my few batch skills to start writing these scripts and learned to do it at the same time. As I don't know any other programming language, using Fusion 2.5 allowed me to quickly provide solutions to the evolutionary needs of RetroBat. I'm aware that using commercial software to read and compile the sources prevents those who don't own the software from accessing the sources of retrobat.mfa file. I specify that this constraint exists only for retrobat.mfa file, all other source files are editable with at least a good text editor such as notepad++* - Kayl

I've written a script to facilitate RetroBat packaging and compilation (WIP). This script will download all the softwares required and the latest compiled RetroBat binaries, it will set all the config files and build the RetroBat setup from NSIS installer sources script.

- [Download and install Git for Windows (follow default setup settings).](https://gitforwindows.org/)

- Open CMD Windows Terminal and run this command to clone recursively the RetroBat git with its submodules:
`git clone --recursive https://github.com/kaylh/RetroBat.git`

- Run build.bat script located at the root of the git to launch the build routine. You need only to follow instructions.

- Once the build process is done, you will find the RetroBat installer at the root of the cloned git.

## 🦇 RetroBat Team

- Adrien Chalard "Kayl" - creator of the project, developer
- Lorenzolamas - community management, graphics
- Fabrice Caruso - lead developer, theme creation
- GetUpOr - community, support
- RetroBoy - community, support

## 🤘 Special Thanks

- Hel Mic - for his generous support and for his wonderful themes.
- Batocera - for their wonderful retrogaming dedicated Operating System.

## ⚖ Licence

RetroBat is a free and open source project. It should not be used for commercial purposes.
It is done by a team of enthusiasts in their free time mainly for fun.

All the code written by the RetroBat Team, unless covered by a licence from an upstream project, is given under the [LGPL v3 licence](https://www.gnu.org/licenses/lgpl-3.0.html).

It is not allowed to sell RetroBat on a pre-installed machine or on any storage devices. RetroBat includes softwares which cannot be associated with any commercial activities.

Shipping RetroBat with additional proprietary and copyrighted content is illegal, strictly forbidden and strongly discouraged by the RetroBat Team.

Otherwise, you can start a new project off RetroBat sources if you follow the same conditions.

Finally, the license which concerns the entire RetroBat project as a work, in particular the written or graphic content broadcast on its various media, is conditioned by the terms of the [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0/).

|<img src="https://www.gnu.org/graphics/gplv3-127x51.png" width="140" alt="gpl3licence" class="center">|<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Cc-by-nc-sa_euro_icon.svg/1280px-Cc-by-nc-sa_euro_icon.svg.png" width="140" alt="cclicence" class="center">|
|---|---|

## © Credits

- EmulationStation (C) 2014 Alec Lofquist, contributions from community.
- RetroArch by Libretro Team.

## 💬 Social & Support

- Official Website: https://www.retrobat.ovh/
- Facebook Group: https://www.facebook.com/groups/retrobat/
- You need help ? You found a bug ? Please visit RetroBat Forum: https://retrobat.forumgaming.fr/
- Join us on our Discord server: https://discord.com/invite/uyrZrKKDeR
