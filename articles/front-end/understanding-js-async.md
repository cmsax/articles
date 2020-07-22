---
title: Understanding Javascript Async
author: cmsax
date: 2020-06-14
---

## Heap & Call Stack

Execution contexts in call stack.

![image-20191017184233049](/Users/mingshicai/Library/Application Support/typora-user-images/image-20191017184233049.png)

## Single Thread & Callback

Do one thing at a time. Callback added to a queue.

Code to be call back later.

## Callback Queue

Callbacks in a queue, FIFO.

## Microtask & Macrotask

microtask in the background / task queue.

macrotask in the main thread.

## Event Loop in Javascript

Wait until the **call stack** is clear, pop a **callback** and push it into **call stack**.

## Microtask & Repaint

![image-20191017191719769](/Users/mingshicai/Library/Application Support/typora-user-images/image-20191017191719769.png)

![image-20191017192155393](/Users/mingshicai/Library/Application Support/typora-user-images/image-20191017192155393.png)

## Webworkers

It has its own event loop.

## Promise & Resolve

A promise object, takes `resolve`, `reject` **callbacks**, with parameters as `value` or `reason`.

When we call a promise, `promiseObject.then((value)=>{}).catch((reason)=>{})`.

Return a promise object in a function intead of **nested callbacks**.

`Promise.all()` runs every single promise, and return all the `resolve` or `reject` parameters.

```javascript
Promise.all(p1, p2, p3)
  .then((values) => {})
  .catch((errors) => {});
```

`Promise.race()` it will return as the first promise resolved and return the single `resolve` value.

## Async / Await

[Reference on Youtube, The async await episode | promise](https://www.youtube.com/watch?v=vn3tm0quoqE)

Make async code read like sync code.

Following code automatically return a promise object.

```javascript
const getEggs = async () => {
  let eggs = ["e", "g", "g", "s"];
  return eggs;
};

let eggs = await getEggs();
```

Or make code simpler:

```javascript
// with async / await
const cookEggs = async () => {
  let a = await getEggs();
  let b = await getEggs();

  return [a, b];
};
```

`await` will pause the code, use `Promise.all` to accelerate your code when necessary:

```javascript
const cookEggs = async () => {
  let a = getEggs();
  let b = getEggs();
  result = Promise.all([a, b]);
  return result;
};
```
