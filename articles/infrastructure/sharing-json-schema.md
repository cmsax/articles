---
title: 利用 JSON Schema 来保障数据流中数据的完整和一致性
author: Mingshi
date: 2020-11-03
---

JSON Schema 是一个比较简单的数据定义规范, 可以先看看官方的文档: [What is a schema](https://json-schema.org/understanding-json-schema/about.html). 利用 JSON Schema 我们可以在项目需求分析阶段确定数据格式, 方便统一文档, 也可以在具体项目中用于数据有效性验证, 确保整个数据流中数据的完整和一致.

## 设计

设计 JSON schema 有点类似于设计 SQL 数据库中的数据表, 设计 SQL 表时需要遵循 3NF, 而在设计 JSON Schema 时需要遵循这些原则:

1. 可组织. 将一个一个小的 schema 模块组织起来获得更复杂的数据结构.
2. 可扩展.
3. 可维护.

我们可以借助一些工具来定义 Model 类, 然后通过类的继承和扩展实现 Schema 的组织/扩展. 比如 Python 中有 pydantic 包可以很方便的将 Model 导出成 JSON Schema.

## 管理和应用

在存储 Schema 时也不必用 JSON 格式, JSON, TOML, YAML 甚至 python 代码都是可以相互翻译转换的, 尽量使用适合已有系统的, 更可读的方式存储 Schema.

将 JSON schema 发布到注册表服务并分配一个 id, 并在数据发送时带上 id, 在数据消费时通过 schema id 进行数据校验. 通过 NACOS 可以很方便地实现这个功能:

![json schema](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20201103100021.png)

也可以通过其他的数据库进行存储, 比如 redis/MySQL/mongoDB 等等.

## 实践

1. 通过 python 代码定义 model
2. 通过 model 动态生成 schema
3. 在 CI/CD 中部署 schema 到 NACOS
4. 在 schema 分组时, 可以参考 redis 的键的设置.
5. 在发送数据时在数据中带上 schema id
6. 在消费数据时根据 schema id 验证数据
