# Articles

[![Build Status](https://travis-ci.com/cmsax/articles.svg?branch=master)](https://travis-ci.com/cmsax/articles)

Automatically build your articles on the cloud with continuous deployment.
You just focus on writing, no deed to install `npm` or `Hexo` on your machine anymore.

`Articles` is enpowered by `Hexo`, `GitHub pages` and currently `Travis-CI`. You write the articles locally,
and we build & publish your articles according your config.

Besides, we should upload, share and manage our original markdowns but not the `site` with CSS/Javascript. 

## Contribution

Pull requests are welcome!

### Codes

`Articles` now supports only 
`travis-ci`, you can help enhance its compatibility, reliability
and flexibility and reduce its complexity to make it support more CI-CD platform.

### Articles

Contribute your excellent articles on `articles` branch.

## Site

Visit: [blog](https://blog.unoiou.com/articles)

## Setup

### GitHub

- Just fork this repository.

### Travis-CI

- Sign up a Travis-CI account on [travis-ci.org](https://travis-ci.org)
(It's free for open-source projects. [travis-ci.com](https://travis-ci.com)
is also supported, but it's not free).

- Install travis-ci on the repository you just forked according to travis-ci's
[document](https://docs.travis-ci.com/) or tutorial.

## Config

### Hexo global config

Set environment variables in `./build.sh`.

### Hexo theme config

Set environment variables in `./build.sh`.

## Start Writing!

Create markdown files under `./articles` or just copy your
existing hexo posts under `./source/_posts` to `./articles`.

## Publish

Just push your local repository to GitHub, then travis-ci will
automatically build your sites on the go.

`sh ./publish.sh` is recommended to use when you really don't have
any commit message to write. ;)

