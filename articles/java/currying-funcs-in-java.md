---
title: Currying Functions with `java.util.function.Function`
author: Mingshi
date: 2020-07-22
---

```java
// Java Program to demonstrate Function Currying

import java.util.function.Function;

public class GFG {
	public static void main(String args[])
	{

		// Using Java 8 Functions
		// to create lambda expressions for functions
		// and with this, applying Function Currying

		// Curried Function for Multiplying u & v
		Function<Integer,
				Function<Integer, Integer> >
			curryMulti = u -> v -> u * v;

		// Calling the curried functions

		// Calling Curried Function for Multiplying u & v
		System.out.println("Multiply 2, 3 :"
						+ curryMulti
								.apply(2)
								.apply(3));
	}
}
```
