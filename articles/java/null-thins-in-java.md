---
title: Null Things in Java
author: Mingshi
date: 2020-03-22
---

## Boxing and Unboxing null object

```java
public class Test
{
	public static void main (String[] args) throws java.lang.Exception
	{
			//An integer can be null, so this is fine
			Integer i = null;

			//Unboxing null to integer throws NullpointerException
			int a = i;
	}
}
```

## Instanceof

```java
public class Test
{
	public static void main (String[] args) throws java.lang.Exception
	{
		Integer i = null;
		Integer j = 10;

		//prints false
		System.out.println(i instanceof Integer);

		//Compiles successfully
		System.out.println(j instanceof Integer);
	}
}
```

## Static and Non-Static

```java
public class Test
{
	public static void main(String args[])
	{
		Test obj= null;
		obj.staticMethod();
		obj.nonStaticMethod();
	}

	private static void staticMethod()
	{
		//Can be called by null reference
		System.out.println("static method, can be called by null reference");
	}

	private void nonStaticMethod()
	{
		//Can not be called by null reference
		System.out.print(" Non-static method- ");
		System.out.println("cannot be called by null reference");
	}
}
```

## Comparison

`null == null`, `null != null`

`true, false`
