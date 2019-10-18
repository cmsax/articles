---
title: Fix Vim Red Background Color Issue on Windows WSL.
author: Mingshi
date: 2019-04-18
---

## Issue

The color of blank space which is outside of the view turns red when I move my cursor to them.

Resize or reopen the Vim window can temporarily fix it.

## Solution

Export a variable called `TERM` can fix this issue permanently.

```bash
export TERM=xterm+256colors
```
