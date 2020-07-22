---
title: MySQL 主从复制
author: Mingshi
date: 2020-05-30
---

## 流程

更新 master 上的 /etc/mysql/m.cnf 文件

```
[mysqld]
log-bin=mysql-bin #开启二进制日志
server-id=1 #设置server-id
```

```sql
create user 'repl'@'%' identified with mysql_native_password by 'password';

grant replication slave on *.* to 'repl'@'%';

flush privileges;

change master to master_host='192.168.0.82',master_port=32795, master_user='repl', master_password='password', master_log_file='mysql-bin.000001', master_log_pos=1413, master_connect_retry=30;

change master to master_host='172.17.0.3', master_user='repl', master_password='password', master_log_file='mysql-bin.000001', master_log_pos=825, master_connect_retry=30;

-- message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection
-- change the encryption of password
ALTER USER 'yourusername'@'localhost' IDENTIFIED WITH mysql_native_password BY 'youpassword';
```

可以指定同步的数据库和表以及日志的保存时间。

## 要求

无论主从还是双主，slave 需要通过固定 ip 访问到 master 服务器。因此，需要设置本地 master 的 bin log 的持续时间，并在该时间内让远程的 slave 连接到本地的 master 进行同步。

腾讯云的 saas 的 mysql 服务没法配置主从备份。

## 参考资料

[博客园文章](https://www.cnblogs.com/gl-developer/p/6170423.html)
