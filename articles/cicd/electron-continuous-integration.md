---
title: Our Solution to Electron Continuous Integration
author: Mingshi
date: 2018-07-06
---

## Background

TDD and Auto DevOps recently have become popular for rapid iteration in small team.

Though I am just a freshman in front-end development, I have to choose a suitable technology stack for our coming project called `Shannon`.

## Solution

### Stack

- Electron for building cross-platform desktop app.
- Electron-Vue as JS framework.
- Spectron as Electron functional TestSuit.
- Vue-test-utils as Vue components unit TestSuit.
- GitLab, GitLab runner as CI-CD envrionment.
- Kubernetes as backend.

### Steps

- Build a docker image for buiding and testing our app.
- Create a `.gitlab-ci.yml` file to config our ci-cd tasks.
- Write our test codes.
- Write our app.
- Improve our test code coverage.
- Iteration.

### Tips

Dependencies of a Docker image for running an Electron app:

- Xvfb
- wine32
- node.js V8
- npm or yarn

The image has been published to docker hub, you can pull it by:

```bash
docker pull windworship/npm-image
```

Do not catch any exceptions in your test code.

