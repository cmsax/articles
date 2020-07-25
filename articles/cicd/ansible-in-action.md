---
title: Ansible: 老项目 Devops 救星
author: Mingshi
date: 2020-07-10
---

注：本文首发于`武大NLP实验室`公众号，ID：`WHU_NLP`，欢迎关注！

## 痛点

实验室服务器数量的增多让基础设施变得更加复杂，当需要更新一些实验和项目所依赖的基础环境时的你：

![环境配置1](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702103555.png)

此外，横跨几届的老项目的部署和维护已经成为了开发人员的噩梦，如果文档不健全，在更新部署时可能需要一天的时间，而文档健全时的情况会好一些，只需要 24 个小时：

<img src="https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702002712.png" alt="环境管理" style="zoom:70%;" />

并且，在多人共享服务器时，权限控制也很麻烦。为了避免某位有 root 权限的用户的误操作如清理了某些目录或者停止了某些核心进程而导致服务器运行异常，管理员往往只给用户普通权限，而这样一刀切的处理方式又会使管理员频繁地因为 root 权限申请被打扰。

![权限管理](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702002732.png)

## 可能的解决方法

那么有什么办法来解决上面的这些问题呢？手动运行命令可能是对基础设施进行维护最直接的方法，但效率实在太低，而且失误的概率较大。

![image-20200702105941121](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702105941.png)

针对具体任务编写小脚本似乎会效率更高，但调试的过程可能会比较痛苦，扩展性、安全性、可读性均比较差，而且运行记录难以追踪、运行后难以回溯。

![image-20200702003352104](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702003352.png)

那么有没有一种简单解决上述问题的方法呢？

## 基础设施/架构即代码(Infrastructure as Code)

![Infrastructure as code defines the environment in a versioned file](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703111856.png)

Infrastructure as Code 简称 IaC，是 DevOps 的一项重要实践，具体就是用一种描述性的(declarative)模型来管理基础设施，比如网络、服务器、虚拟机、负载平衡器及他们的拓扑结构等资源。IaC 的重要原则是幂等性，对于一套固定的基础设施，相同的描述性的配置总会让基础设施进入到一个相同的状态。这种幂等性让基础设施的状态可复制、可扩展、可追踪并且可回溯。IaC 通常和持续交付结合使用。

IaC 实践中通常使用一种描述性的编码语言，如 JSON, YAML, XML 等，这些语言大多简单易学，且具备良好的可读性。下面这段 YAML 代码所描述的内容和 MarkDown 十分类似，相信不是程序员也能理解其含义。

```yaml
# Employee records
- martin:
    name: Martin D'vloper
    job: Developer
    skills:
      - python
      - perl
      - pascal
- tabitha:
    name: Tabitha Bitumen
    job: Developer
    skills:
      - lisp
      - fortran
      - erlang
```

### 可用方案对比

IaC 发展已久，目前有许多可用方案。

![IaC 方案对比](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703115355.png)

通过从易用性、扩展性和价格等维度对比已有的 IaC 方案，我们发现 Ansible 是一个比较好的选择。除此之外，Ansible 相比于其他的项目，还有一项最重要的特点，在于 Agentless，即无客户端/无代理的运行模式。

### Ansible：开源的基础设施即代码解决方案

![image-20200703120008312](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703120008.png)

Ansible 的第一个版本发布于 2012 年 2 月，至今已经迭代了很长时间。

Ansible 基于纯文本 YAML 文件来描述资源的行为、状态或者特定任务，几乎所有地方都支持设置变量，包括 playbook、文件、inventory、命令、从受控主机传回的变量等。使用 Ansible 的项目具有高可读性（人 & 计算机）。

简单来说，它具有这些特点：

- 简单 👴
  - 基于 yaml，高可读性
  - 不需要特定的开发技能
  - 基于已有的社区轮子快速部署
- 强大 👍
  - 应用部署
  - 配置管理
  - 定制工作流
  - 管理应用的生命周期
- 无代理 👏
  - 无代理架构
  - 基于 OpenSSH & WRM(远程 Powershell)
  - 无需更新配置
  - 更安全可靠、更高效

### Ansible 架构

![img](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702003725.png)

Ansible 架构简单直接，Inventory 代表受管理的节点或其他资源，用户在建立控制节点到受控节点的连接后，通过直接指定命令或编写一种叫做 Playbook 的配置文件来执行特定的任务。对于 Linux 节点，使用 SSH 建立连接；而对于 Windows 节点，则使用 WRM(Windows Remote Management) 服务。

### Ansible 对象

在 Ansible 中，我们通常会用到这些对象：

- Inventory：受控资源，如主机
- Modules：预定义且可扩展的用于执行特定任务的模块
- Tasks：用户描述的特定的任务
- Playbooks：用户描述的特定任务集，描述一系列特定的任务及配套行为

![image-20200703122053922](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703122054.png)

此外，Ansible 还有一个类似于 GitHub 的社区，叫 Ansible Galaxy。在这个社区中，有大量社区成员预定义的解决特定任务的工具包，我们既可以直接下载使用，也可以将合适的工具包集成到自有的 Playbooks 中。

## 在实验室的应用案例

### 需求背景

实验室中有许多的老项目，这些项目的测试和生产环境尚未分离，测试依赖于 Monkey Test；部署和运行依赖于特定的运行环境，且需要大量的手工操作，成功率较低。

迁移这些老项目到新的 Kubernetes 集群的开发成本较高，因此我们希望借助于 Ansible 来解决这些问题，实现这些功能：

- 测试和生产环境分离
- 旧项目依赖的版本控制
- 权限控制
- 不同依赖之间环境隔离
- 可追踪、回溯、扩展
- 自动部署

### 具体应用

对于旧项目，在坚持采用规范的开发流程的前提下，一个新的 Feature 从第一个 MR（Merge Request 合并请求） 到成功上线在时序图中需要超过 30 步的操作。这样的流程过度依赖人工，不同的环境依赖于不同的 GitLab Runner，而 Runner 的设置与具体项目耦合，频繁更改单个项目的 Runner 容易出错，而为测试和生产项目设置不同的 Runner 则会徒增许多重复的项目，衍生出许多其他的问题。

![image-20200702004157733](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200702004157.png)

因此，我们将 GitLab CI 和 Ansible 结合。具体来说包含这些关键步骤：

- 准备多台主机（虚拟），并添加到 Ansible Inventory 中
- 在 GitLab 创建一个用于管理旧项目基础架构的项目，并指定 Runner 为 Ansible 控制节点
- 在 Ansible 项目中，为生产环境和测试环境指定不同的 Inventory，创建 Playbook 定义旧项目构建、部署、测试任务的具体行为、状态和依赖的环境
- 定义 GitLab CI 流水线，配置持续集成和持续部署

通过这些关键步骤，我们实现了预期的功能。具体来说：

1. 项目开发者提交代码后触发 GitLab 流水线，Ansible 控制节点会运行 Playbook 中定义的行为，在测试环境中更新依赖并运行测试任务
2. 在 MR 通过后 Ansible 控制节点自动在预发布(Staging)环境中部署
3. 项目管理者确认 Staging 环境中功能正常后，点击 GitLab 流水线的手动操作即可按照设定比例 10%，50%，100% 等更新生产环境。

下图是我们 Ansible 项目中的具体文件，其中 `.gitlab-ci.yml` 是 GitLab CI 流水线配置文件，而 `build.yaml`, `test.yaml` 和 `deploy.yaml` 则是 Ansible Playbook 文件。通过将项目的依赖和行为描述成 YAML 文件，我们可以将依赖、环境、行为的更新转化成对代码仓库的一次 MR。

![image-20200703125905619](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703125905.png)

下图是流水线运行的截图，其中 `deploy` 是手动操作，用于将项目部署到 `staging` 环境。

![image-20200703125803430](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703125803.png)

### 效果对比

某不愿透露姓名的项目组成员表示，对于旧项目的更新和部署，再也不用担心秃头了。

![image-20200703123501733](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20200703123501.png)

### Ansible 最佳实践指南

根据我们的开发经验和 Ansible 官方指南，我们认为基于 Ansible 开发需要遵循以下原则：

- 代码越复杂，生产效率越低
- 提高 Playbook 中的任务和变量定义的可读性
- 依据声明式的思想编写 Playbook 文件，Playbook 不是 Coding
- 请为 Ansible Playbook 编写单元测试

### Ansible 的局限

我们也发现了 Ansible 的一些局限，主要是：

1. Ansible 比较适合部署老的项目，新的项目不建议使用，请直接上 Kubernetes 谢谢。
2. Ansible 不支持服务的底层环境隔离，如网络、系统内核版本等。
3. Ansible 的响应速度不行，尤其是文件传输速度太慢（如果无法忍受，可以自己写 Module，根据特定业务需求扩展文件传输算法，使用文件分块算法等方式）

对于新项目的更优的选择：以 Kubernetes, OpenStack, Openshift 为代表的服务编排平台，支持操作系统即代码、服务编排、网络隔离等高级特性。

### 效果与展望

实验室的大多数项目已经部署在了 Kubernetes 上，对于老项目而言，Ansible 无疑是最佳选择。通常，实验室中一个项目组使用了 Ansible 后，其他项目组也可以参考已有的写法快速实现实现自己项目的自动化部署。

安全性、可维护性、可扩展性和易用性是我们的追求，相信随着 DevOps 技术的发展，未来我们可以为实验室项目成员提供更好的 DevOps 体验。

## 参考资料

> - Infrastructure as Code: https://en.wikipedia.org/wiki/Infrastructure_as_code
> - Ansible Repository: https://github.com/ansible
> - YAML language spec: https://yaml.org/spec/1.2/spec.html
> - Ansible official documentation: https://docs.ansible.com/
> - Ansible Galaxy: http://galaxy.ansible.com/
> - Ansible Module Index: https://docs.ansible.com/ansible/latest/modules/modules_by_category.html
> - GitLab CI official documentation: https://docs.gitlab.com/ce/ci/
> - YAML Syntax: https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html
> - Ansible Best Practices ANSIBLE BEST PRACTICES: THE ESSENTIALS
