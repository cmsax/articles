---
title: 使用 Helm 部署有状态服务到 Kubernetes 上
author: Mingshi
date: 2020-06-18
---

## 原生 k8s 部署有状态服务

### Related k8s resources

`ConfigMap`: 公开的键值对，在运行时会将配置文件、命令行参数、环境变量、端口号以及其他配置软件工件绑定到 Pod 的容器和系统组件。将配置与 Pod 和组件分开，这有助于保持工作负载的可移植性，使其配置更易于更改和管理，并防止将配置数据硬编码到 Pod 规范

`Secret`: 私有的、加密的，存储敏感配置信息

`Service`:

`PersistentVolumeClaim`: 被集群动态分配的持久化存储

`Deployment`:**不具有唯一标识**的一组多个相同的 Pod，运行应用的多个副本，自动替换失败或者无响应的实例以确保所需的数量的 Pod。比较适合**无状态应用**，使用 Pod 模板。[GCP 文档](https://cloud.google.com/kubernetes-engine/docs/concepts/deployment?hl=zh-cn)

`Pod`: 最基本的对象，包括一个或者多个容器

`StatefulSet`: 与 Deployment 相对，表示具有唯一标识的一组 Pod。用于部署[有状态应用](https://cloud.google.com/kubernetes-engine/docs/how-to/deploying-workloads-overview?hl=zh-cn#stateful_applications)和集群应用，以将数据保存到永久性存储空间，适合部署 Kafka、MySQL、Redis、ZooKeeper 以及其他需要唯一持久身份和稳定主机名的应用。
