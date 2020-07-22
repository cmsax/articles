---
title: Secret & Config in K8s and Helm
author: Mingshi
date: 2020-06-29
---

- Secret 在 helm 中可以很方便地通过 template 来定义，并会自动创建到对应命名空间
- 可以将 secret 作为 volume 挂载到 pod
- 挂载的地址不能是 / 根目录，否则会将容器的根目录都设置成虚拟化的目录
- 可以根据需要，将 secret 中的对应的 key 映射到具体的文件名
