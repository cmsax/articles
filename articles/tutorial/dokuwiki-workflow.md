---
title: Best Practice of Dokuwiki Workflow, Better Than OneNote
author: Mingshi
date: 2019-10-18
---

## Motivation

[DokuWiki](https://www.dokuwiki.org/dokuwiki) is a powerful self-host wiki system. Content in a DokuWiki site is all static s.t. we can easily backup or restore our documents.

I use DokuWiki a lot, and I prefer to write markdown files locally on my computer and then create a page on DokuWiki web page.
However, this is not suitable for well-organized files and takes a lot of time, besides, I alwayse forget to upload the files or just can't remember which files are not on the cloud.

So I need an automation workflow to help me simplify jobs above.

Git is the perfect tool for this situation, it's distributed and easy to control version of files. So I created a DokuWiki workflow based on Git.

## Structure

![Structure](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20191018191649.png)

## Setup a DokuWiki Site

Just create a docker container and mount a `volume` where you put the persistent DokuWiki files.

## Backup

Generally, after I established a DokuWiki site, I just initialize a repository in DokuWiki's root directory, known as `dokuwiki/` and regularly push it to GitHub and other git mirrors as a backup using `crontab`.

## Write locally & Update Remotely

The core content of a DokuWiki is inside the directory of `dokuwiki/data/pages`, so just initialize another sub repository here and push it to GitHub. Then pull the git repository to your local computer, push to GitHub repository after you update the wiki.

The DokuWiki site needs to keep pace with local repository, so add another `crontab` job to pull the git repository.

Notice that files in DokuWiki directory is owned by `daemon` by default, after `sudo git pull` the files are owned by `root`, that is, DokuWiki itself cannot modify them, in other words, you cannot edit the pages on DokuWiki webpage, which is just what we want it to be in order to prevent version conflict.

### Suggested Tool Chain

DokuWiki uses `.txt` files as pages, in order to treat them as markdown files, you need to put a `workplace` setting file `.vscode/settings.json` for vscode. The file content maybe following:

```json
{
  "files.associations": {
    "*.txt": "markdown"
  },
  "workbench.colorTheme": "Dracula",
  "[markdown]": {
    "editor.quickSuggestions": true,
    "editor.wordWrap": "on"
  }
}
```

For further info about vscode settings and code-snippets please read the official documentation of vscode.

Thanks for reading!
