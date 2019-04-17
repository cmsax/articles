---
title: Fix WSL Vim Font Issue on Windows 10
date: 2019-04-18
---

## Issue

After installed `Vim` on `wsl`, I found that the display font changed to `SimSun`(A very ugly font) when I open Vim.

I tried to use `:set guifont font-name` but it didn't work at all, it annoyed me a lot. The hatred of Windows-fucking-bug-10 had seen absolute growth. :(

## Solution

Fourtunately, I found a solution by editing `Registry` on Windows 10.

- Add a new `DWORD` record in `HKEY_CURRENT_USER\Console\C:_Program Files_WindowsApps_CanonicalGroupLimited.UbuntuonWindows_1804.2018.817.0_x64__79rhkp1fndgsc_ubuntu.exe` named `CodePage`
- Set it to `Decimal` and value `65001` or `Hexadecimal` and value `fde9`

It's fucking working now. Fuck!

