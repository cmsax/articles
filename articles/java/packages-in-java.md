---
title: Packages in Java
author: Mingshi
date: 2020-03-27
---

## User Defined Packages

First we create a directory myPackage (name should be same as the name of the package). Then create the MyClass inside the directory with the first statement being the package names.

## Directory Structure

`BASE_DIR` and `CLASSPATH`

The base directory ($BASE_DIR) could be located anywhere in the file system. Hence, the Java compiler and runtime must be informed about the location of the $BASE_DIR so as to locate the classes. This is accomplished by an environment variable called CLASSPATH. CLASSPATH is similar to another environment variable PATH, which is used by the command shell to search for the executable programs.

可以将 jar 包直接加到 `CLASSPATH` 中，然后就可以正常引用这个包了。

## Ref

[geeksforgeeks](https://www.geeksforgeeks.org/packages-in-java/)
