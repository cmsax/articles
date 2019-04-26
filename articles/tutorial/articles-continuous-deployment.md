---
title: Automatically Deploy Your Documents by Continuous Delivery
author: Mingshi
date: 2019-04-17
---

Static sites generators such as Hexo, Jekyll, and Hugo etc. have save us from handling CSS/Javascript things. However, we still need to spend a lot of time to configurate generators and build our sites locally then publish/upload it to host.

With the help of continuous-integration platform, we may let the CI platform do the devil jobs. We just write markdowns, send them to the pipeline, then we are free to go.

So I started a project called [`Articles`](https://github.com/cmsax/articles), it can automatically build your articles on the cloud with continuous deployment.

You just concentrate on writing and never install `npm` or `Hexo` on your machine.

`Articles` is enpowered by Hexo, `GitHub pages` and currently `Travis-CI`. You write the articles locally, and we build & publish your articles according your config.

You can find more information [here](https://github.com/cmsax/articles)

