---
title: Advance in Kubernetes (1)
author: cmsax
date: 2020-06-20
---

## 修复 RethinkDB 中尚存在的问题

- persistentVolumeClaim 拿不到 PV 的原因未知，可能是 pv 没创建对？可能是 pvc 的要求不满足？
- 尝试了 hostPath 但尚未尝试其他类型的 pv

## 存储卷

- Volume 和 PersistentVolume 用于 pod 存储数据
- hostPath 作为 host 上的一个物理的文件夹不支持并发读写

## Affinity 和 AntiAffinity

- Pod 和 Node 都能够设置相互的亲和度和逆亲和度
- 通过 Label 或者其他的一些可哈希的具有唯一标志的资源来判断

## Taint 和 Tolerance

- 可以设置 Node 存在一些「污点」，即 Taint ，只有忍受 Node 的**全部**污点的 Pod 才能够被分配到这个有污点的 Node 上乃至在上面运行
- Node 偶尔会根据污点「驱逐」一些 Pod ，即使 Pod 忍受了这些污点，还是可能被驱逐。因此还可以设置 Pod 被驱逐后在 Node 上存活的时间长度

## 几种重要的资源的理解

- ReplicaController 是比较基础的资源，用于定义一些 Pod
- Deployment 是早期定义一组服务的比较常用的资源，后来被 Statefule-Set 所取代
- Service 不包含 Pod 定义，主要用在服务发现中，定义集群向外暴露的服务
- Ingress 使用反向代理和服务发现机制，将给定 Name 的 Service 通过特定的 Port 和 HostName 暴露出去

以上所有资源都可以通过 `kubectl create -f aaaa.yaml` 来创建

## 使用 Helm

使用 Helm 管理部署非常简单，但偶尔还需要手动改一下项目的 Chart 模板。
