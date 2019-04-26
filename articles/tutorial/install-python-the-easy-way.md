---
title: Install Python on Windows the Easy Way
author: Mingshi
date: 2019-04-26
---

## Background

The sane way to manage software on Windows is using `Chocolatey`. It makes it possible and uncomplicated to install softwares automatically by just one command as easy as abc.

Besides, it's open source and totally free for personal use. There are over 6500 community maintained packages on `Chocolatey` includes common softwares like Python, Adobe PDF Reader, Web Browsers and Anaconda.

The install process is smooth, just type a line of command and click `Enter`, you will have your well configured software installed after a cup of tea.

## Steps

### Install Chocolatey

> Checkout this [official tutorial](https://chocolatey.org/install) for installing `Chocolatey`.

1. Right click the Windows icon on bottom-left of your screen, and click `Powershell (as Admin)` option like below:

![t1](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t1.png)

2. When the User-Account-Control windows displays, click `Yes`.

![t2](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t2.png)

3. Paste the scripts below to the window:

```Powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

![t3](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t3.png)

4. Type `Enter`, when it finished, the window should be like below:

![t4](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t4.png)

5. Check the installation. Type `choco` or `choco -?`, if you get result like below, it means the installation is OK.

![t5](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t5.png)

6. Reboot your computer to activate some functionality of `Chocolatey`.

Done!

### Install Python

#### Commands

Try `choco -?` to see its brief introduction. In this case, you will use following commands:

```cmd
choco list
choco search [software_name]
choco install [software_name1, software_name2, ..., software_nameN]
```

To list local packages, type `choco list` on PowerShell.

To search specific software or package, e.g. Python, just type `choco search python`.

To install packages or softwares, e.g. Python and Anaconda, just type `choco install python3 python2 anaconda`

#### Easy Way

Open your browser and go to [https://chocolatey.org/packages](https://chocolatey.org/packages).

Search the package you want.

![t6](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t6.png)

Now you get the available packages and installation command.

![t7](https://seccdn.unoiou.com/img/articles/tutorial-install-chocolatey/t7.png)

Copy the installation command and paste it to PowerShell window. Click `Enter` to run it.

