 <img src="https://www.retrobat.ovh/img/retrobat_logo.svg" alt="RetroBat-Logo" class="center"> 

[Official Website](https://www.retrobat.ovh) | [Facebook Group](https://www.facebook.com/groups/retrobat)

## Introduction

RetroBat is designed to configure automatically EmulationStation frontend with RetroArch and standalone emulators.

With it you will be quickly able to run games from a ROMs collection. You can save a lot of time you can keep to play !

RetroBat can download and install all software you need to have a good retro gaming experience on your Windows PC.

RetroBat can run in Portable Mode. That means you can start it from HDD or from any removable storage device, as long as you do it on a computer that meets the requirements.

## System requirements

|   |   |
|---|---|
|**OS supported:**|Windows 10, Windows 8.1, Windows 7 SP3 (64 bit)|
|**Processor:**|CPU with SSE2 support. 3 GHz and Dual Core, not older than 2008 is highly recommended.|
|**Graphics:**|Modern graphics card that supports Direct3D 11.1 / OpenGL 4.4 / Vulkan|
|**Dependancies:**|[Visual C++ 2010 Redistributable Packages (32 bit)](https://www.microsoft.com/en-US/download/details.aspx?id=5555)|
|   |[Visual C++ 2015, 2017 and 2019 Redistributable Packages (32 bit)](https://aka.ms/vs/16/release/vc_redist.x86.exe)|
|   |[Visual C++ 2015, 2017 and 2019 Redistributable Packages (64 bit)](https://aka.ms/vs/16/release/vc_redist.x64.exe)|
|   |[DirectX](https://www.microsoft.com/download/details.aspx?id=35)|

## Supported machines

![Supported Machines](https://www.retrobat.ovh/img/systems4.png)

**RetroBat will never provide ROMs or BIOS files.**

## Compiling

To read and build retrobat.mfa sources file you need a legit copy of Fusion 2.5 developper.

To build .nsi files you need the NullSoft Scriptable Install System.

Why use proprietary development software like Clickteam Fusion 2.5? 

*Until version 2.1, retrobat consisted mainly of a collection of batch and powershell scripts to facilitate the use and configuration of EmulationStation with RetroArch. I didn't originally have any training in software development, I used my few batch skills to start writing these scripts and learned to do it at the same time. As I don't know any other programming language, using Fusion 2.5 allowed me to quickly provide solutions to the evolutionary needs of RetroBat. I'm aware that using commercial software to read and compile the sources prevents those who don't own the software from accessing the sources of retrobat.mfa file. I specify that this constraint exists only for retrobat.mfa file, all other source files are editable with at least a good text editor such as notepad++* - Kayl

You can download [here](https://www.dropbox.com/sh/wp6ed3wlro9x7th/AADQFQCZNQlmhLeo1EqmHoI3a?dl=0) the sources of retrobat.mfa in pdf format to preview the Fusion code.

I've written a script to facilitate retrobat packaging and compilation. Download retro.bat [here](https://www.dropbox.com/s/mj9mmq225bm797k/retro.bat?dl=0). (WIP)

## RetroBat Team

- Adrien Chalard "Kayl" - creator of the project, coder, testing
- Lorenzolamas - community management, assets, testing
- Fabrice Caruso - programmer, theming

## Special Thanks

- Hel Mic - for his generous support.
- Batocera - for their wonderful retrogaming dedicated OS.

## Licence

RetroBat is free and open source project. It should not be used for commercial purposes.
It is done by a team of enthusiasts in their free time mainly for fun.

All the code written by RetroBat Team, unless covered by a licence from an upstream project, is given under the [LGPL v3 licence](
http://www.gnu.org/licenses/lgpl-3.0.html).

It is not allowed to sell RetroBat on a pre-installed machine or on any storage devices. RetroBat includes softwares which cannot be associated with any commercial activities.

Shipping RetroBat with additional proprietary and copyrighted content is illegal, strictly forbidden and strongly discouraged by the RetroBat Team.

Otherwise, you can start a new project off RetroBat sources if you follow the same conditions.

Finally, the license which concerns the entire RetroBat project as a work, in particular the written or graphic content broadcast on its various media, is conditioned by the terms of the [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0).


## Credits

- EmulationStation (C) 2014 Alec Lofquist, contributions from community.
- RetroArch by Libretro Team.

## Support

You need support ? You found a bug ? Please go on RetroBat Forum: https://retrobat.forumgaming.fr/
