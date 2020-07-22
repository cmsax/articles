---
title: Golang Concurrency Pattern
author: cmsax
date: 2020-07-22
---

注意：以下所说的线程、进程、协程都是指一个东西：`goroutine`

## 5 种模式

- 最大输入的管道
- 任务分解多个协程，结果彼此无关
- 线程安全的数据结构，不需要锁
- 三种方法，将任务分成固定多个协程，并在最后合并结果
- 创建进程依赖的数量的协程，并在最后合并结果

## 死锁

- 因为没有完成信号，所有协程都没有退出，即使任务已经完成
- 阻塞的线程想要获得其它正在阻塞的线程的锁

使用 done 通道报告结果。

使用 sync.WaitGroup ，但当其它线程正在阻塞，而 sync.WaitGroup.Wait() 在主进程被调用时，就会出现死锁。

使用 Channel 依然会导致死锁，比如

## 线程安全性

安全：bool, int, float64, string

不安全：

- 引用类型，除非 1.互斥量 2.访问规则 3.不修改
- 定义了修改的接口类型

没有缓冲区的通道会立即阻塞，直到有其它进程从中读取。缓冲区能够提高吞吐量。

发送端的进程关闭通道

单向通道表达程序思想

通道关闭

合理设置缓冲区大小和进程数量，尽可能将不必要的阻塞降低到最低

带有通道参数的函数，通常将目标通道放在前面，源通道放在后面。

双向通道才允许关闭

使用非阻塞 select，可通过 timeout 退出

线程安全的映射，能够被多个线程共享。只要按照 safemap/safemap.go 定义的 SafeMap 接口实现就行。

> 可导出/不可导出的接口

## 同步

- 对于从无缓冲 Channel 进行的接收，发生在对该 Channel 进行的发送完成之前
- 对于带缓冲的 Channel，对于 Channel 的第 K 个接收完成操作发生在第 K+C 个发送操作完成之前，其中 C 是 Channel 的缓存大小