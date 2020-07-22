---
title: Bounded Type Parameter
author: Mingshi
date: 2020-07-22
---

## Bounded Type

```java
// This class only accepts type parametes as any class
// which extends class A or class A itself.
// Passing any other type will cause compiler time error

// LOOK AT ME!
class Bound<T extends A>
{

	private T objRef;

	public Bound(T obj){
		this.objRef = obj;
	}

	public void doRunTest(){
		this.objRef.displayClass();
	}
}

class A
{
	public void displayClass()
	{
		System.out.println("Inside super class A");
	}
}

class B extends A
{
	public void displayClass()
	{
		System.out.println("Inside sub class B");
	}
}

class C extends A
{
	public void displayClass()
	{
		System.out.println("Inside sub class C");
	}
}

public class BoundedClass
{
	public static void main(String a[])
	{

		// Creating object of sub class C and
		// passing it to Bound as a type parameter.
		Bound<C> bec = new Bound<C>(new C());
		bec.doRunTest();

		// Creating object of sub class B and
		// passing it to Bound as a type parameter.
		Bound<B> beb = new Bound<B>(new B());
		beb.doRunTest();

		// similarly passing super class A
		Bound<A> bea = new Bound<A>(new A());
		bea.doRunTest();

	}
}
```

## Multiple Bound

```java
// LOOK AT ME!
class Bound<T extends A & B>
{

	private T objRef;

	public Bound(T obj){
		this.objRef = obj;
	}

	public void doRunTest(){
		this.objRef.displayClass();
	}
}

interface B
{
	public void displayClass();
}

class A implements B
{
	public void displayClass()
	{
		System.out.println("Inside super class A");
	}
}

public class BoundedClass
{
	public static void main(String a[])
	{
		//Creating object of sub class A and
		//passing it to Bound as a type parameter.
		Bound<A> bea = new Bound<A>(new A());
		bea.doRunTest();

	}
}
```

## Ref

[bounded type parameter](https://www.geeksforgeeks.org/bounded-types-generics-java/)
