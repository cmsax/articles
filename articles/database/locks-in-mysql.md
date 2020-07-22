---
title: MySQL 锁相关知识总结
author: Mingshi
date: 2020-07-22
---

## 事务

数据库事务: **事务(Transaction)**，一般是指要做的或所做的事情。在计算机术语中是指访问并可能更新数据库中各种数据项的一个程序执行单元(unit)。在计算机术语中，事务通常就是指数据库事务。

一个数据库事务通常包含对数据库进行读或写的一个操作序列。它的存在包含有以下两个目的：

> 1、为数据库操作提供了一个从失败中恢复到正常状态的方法，同时提供了数据库即使在异常状态下仍能保持一致性的方法。
> 2、当多个应用程序在并发访问数据库时，可以在这些应用程序之间提供一个隔离方法，以防止彼此的操作互相干扰。

即:1.当一个事务被提交给了 DBMS（数据库管理系统），则 DBMS 需要确保该事务中的所有操作都成功完成且其结果被永久保存在数据库中，如果事务中有的操作没有成功完成，则事务中的所有操作都需要被回滚，回到事务执行前的状态（要么全执行，要么全都不执行）; 2.同时，该事务对数据库或者其他事务的执行无影响，所有的事务都好像在独立的运行。

**事务的 4 个属性 acid**: atom 原子性,作为一个整体被执行,consistency 一致性,数据满足完整性约束,isolation 隔离性,不影响其他事物,durability 持久性,事务执行成功后对数据库的修改被永久记录.

## 事务隔离级别

Mysql 可以设置 4 个隔离级别,允许用户在性能和可靠性之间作出选择.

Read uncommitted, **会出现读到了未提交的数据(脏读);** 事务 b 读到了事务 a 尚未提交的数据,该数据可能会被事务 a 回滚.即**脏读**.

read committed, **会出现读到的数据被别的事务提交更新了,也就是在同一个事务中,两次读到的数据不是一致的**(**不可重复读**); 事务 a 先读取了数据,事务 b 也读区了,但 b 更新了数据并提交了事务,而 a 再次读数据时,数据已经变了.即**不可重复读**.

repeatable read, mysql 的默认隔离级别;尽管通过 **Next-Key Lock** 某种程度上解决了幻读读问题,但仍可能出现幻读(事务在插入事先检测不存在的记录时，惊奇的发现这些数据已经存在了，之前的检测读获取到的数据如同鬼影一般。**\*在一个事务中，同一个范围内的记录被读取时，其他事务向这个范围添加了新的记录**。\*).

**幻读例子**: 重新开启了两个会话 `SESSION 1` 和 `SESSION 2`，在 `SESSION 1` 中我们查询全表的信息，没有得到任何记录；在 `SESSION 2` 中向表中插入一条数据并提交；由于 `REPEATABLE READ` 的原因，再次查询全表的数据时，我们获得到的仍然是空集，但是在向表中插入同样的数据却出现了错误。

这种现象在数据库中就被称作幻读，**虽然我们使用查询语句得到了一个空的集合，但是插入数据时却得到了错误，好像之前的查询是幻觉一样**。

serializable.**串行**;最高级别,但是代价高,性能低,一般很少使用,**事务串行执行**.通常,在实际应用中自己加锁来避免幻读.

|     | 脏读     | 不可重复读 | 幻读     |
| --- | -------- | ---------- | -------- |
| Ru  | 可能出现 | 可能出现   | 可能出现 |
| Rc  |          | 可能出现   | 可能出现 |
| Rr  |          |            | 可能出现 |
| S   |          |            |          |

## 并发控制

**悲观锁**：假定会发生并发冲突，\*\*屏蔽一切可能违反数据完整性的操作。InnoDB 使用的是悲观锁.

**乐观锁**：假设不会发生并发冲突，**只在提交操作时检查是否违反数据完整性**。不是一种真正的锁,冲突了就重试,没有对数据库加锁.**乐观锁因为没有真正加锁,所以不能解决脏读的问题**。它会先尝试对资源进行修改，在写回时判断资源是否进行了改变，如果没有发生改变就会写回，否则就会进行重试，

乐观锁不会存在死锁的问题，但是由于更新后验证，所以当**冲突频率**和**重试成本**较高时更推荐使用悲观锁，而需要非常高的**响应速度**并且**并发量**非常大的时候使用乐观锁就能较好的解决问题，在这时使用悲观锁就可能出现严重的性能问题；在选择并发控制机制时，需要综合考虑上面的四个方面（冲突频率、重试成本、响应速度和并发量）进行选择。

## 锁的分类

**共享锁**代表了读操作、互斥锁代表了写操作，所以我们可以在数据库中**并行读**，但是只能**串行写**，只有这样才能保证不会发生线程竞争，实现线程安全。

锁的粒度,包括**行锁、表锁**,还引入了**意向锁**,是一种表级锁.

**意向锁**其实不会阻塞全表扫描之外的任何请求，它们的主要目的是为了表示**是否有人请求锁定表中的某一行数据**。

理解意向锁的目的: 我们在这里可以举一个例子：如果没有意向锁，当已经有人使用行锁对表中的某一行进行修改时，如果另外一个请求要对全表进行修改，那么就需要对所有的行是否被锁定进行扫描，在这种情况下，效率是非常低的；不过，在引入意向锁之后，当有人使用行锁对表中的某一行进行修改之前，会先为表添加意向互斥锁（IX），再为行记录添加互斥锁（X），**在这时如果有人尝试对全表进行修改就不需要判断表中的每一行数据是否被加锁了，只需要通过等待意向互斥锁被释放就可以了。**

## 锁的算法

**记录锁 record lock** 添加到**索引记录**上的锁.在建表时如果指定了 `key` 那么,InnoDB 就能通过 B+树找到行记录并添加索引.否则,不知道待修改的记录具体的位置,只能锁定整个表.

**间隙锁 gap lock** 是对索引记录中的一段连续区域的锁；当使用类似 `SELECT * FROM users WHERE id BETWEEN 10 AND 20 FOR UPDATE;` 的 SQL 语句时，就会阻止其他事务向表中插入 `id = 15` 的记录，因为**整个范围都被间隙锁锁定**了。

> _间隙锁是存储引擎对于性能和并发做出的权衡，并且只用于某些事务隔离级别。_

虽然间隙锁中也分为共享锁和互斥锁，不过它们之间并不是互斥的，也就是不同的事务可以同时持有一段相同范围的共享锁和互斥锁，它唯一阻止的就是**其他事务向这个范围中添加新的记录**。

**记录锁和间隙锁的结合:Next-Key Lock** 既然叫 Next-Key 锁，锁定的应该是当前值和后面的范围，但是实际上却不是，Next-Key 锁锁定的是当前值和前面的范围.当我们更新一条记录，比如 `SELECT * FROM users WHERE age = 30 FOR UPDATE;`，InnoDB 不仅会在范围 `(21, 30]` 上加 Next-Key 锁，还会在这条记录后面的范围 `(30, 40]` 加间隙锁，所以插入 `(21, 40]` 范围内的记录都会被锁定。

Next-Key 锁的作用其实是为了解决**幻读**的问题.

**不使用索引来更新,会导致表锁的情况.**

参考资料:[『浅入浅出』MySQL 和 InnoDB](https://draveness.me/mysql-innodb#)