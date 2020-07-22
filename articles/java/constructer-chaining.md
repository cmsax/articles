---
title: Constructor Chaining
author: Mingshi
date: 2020-03-12
---

Following code demonstrates it:

```java
class Test
{
    final public int i;

    Test(int val)    {  this.i = val;  }

    Test()
    {
        // Calling Test(int val)
        this(10);
    }

    public static void main(String[] args)
    {
        Test t1 = new Test();
        System.out.println(t1.i);

        Test t2 = new Test(20);
        System.out.println(t2.i);
    }
}
```
