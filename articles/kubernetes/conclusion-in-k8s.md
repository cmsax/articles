---
title: Kubernetes 总结 (1)
author: Mingshi
date: 2020-06-14
---

## 简单版本

### 部署一个 docker 应用

**下面都没指定 namespace，但实际很需要。**

创建一个 deployment 资源。

`kubectl run hello-web --image=IMAGE_URL --port PORT`

暴露 pod 端口，创建一个 service 资源。

`kubectl expose deployment hello-web --type=LoadBalancer --port 80 --target-port 8080`

扩展应用。

`kubectl scale deployment hello-web --replicas=3`

### 更新应用

直接设置 deployment 的镜像即可。

`kubectl set image deployment/hello-web hello-web=IMAGE_URL`

## 使用 Ingress 负载平衡

### 创建 ingress 资源

在简单版本中，创建完了 service 资源后，可以查看 service 的集群地址和端口。

`kubectl get service web`

创建 Ingress 资源，它封装了一系列规则和配置，可将外部 HTTP(S) 流量路由到内部服务。

创建类似下面的文件：

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: basic-ingress
spec:
  backend:
    serviceName: web
    servicePort: 8080
```

然后执行 `kubectl apply -f basic-ingress.yaml`，过一会儿

执行 `kubectl get ingress basic-ingress`，查看负载平衡器的外部 IP 地址，如：

```shell
NAME            HOSTS     ADDRESS         PORTS     AGE
basic-ingress   *         203.0.113.12    80        2m
```

就能通过外部地址访问了。

### 配置 静态 ip、不同子路径

在创建 ingress 后，指定了端口，并获得了 ip，但存在两个问题：

1. 外部 ip 不是静态的，会发生变化
1. 端口 8080 肯定会与其他应用冲突，我们需要使用反向代理把需要的 web 服务 8080 端口暴露出去，并通过 hostName 区分不同的服务

因此我们需要静态 ip、dns 服务和反向代理服务。

更新 ingress yaml 文件：

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: basic-ingress
  annotations:
    kubernetes.io/ingress.global-static-ip-name: "web-static-ip"
spec:
  backend:
    serviceName: web
    servicePort: 8080
```

也可以在一个 ingress 服务中处理多个应用，参考上面的步骤创建另一个 web 服务，然后更新 ingress 文件：

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: fanout-ingress
spec:
  rules:
    - http:
        paths:
          - path: /*
            backend:
              serviceName: web
              servicePort: 8080
          - path: /v2/*
            backend:
              serviceName: web2
              servicePort: 8080
```

注意：**这样能够实现同一个域名使用不同子路径提供不同的 web 服务，比如 api 服务和 web 服务**

### 反向代理与 k8s 上的 DNS 服务
