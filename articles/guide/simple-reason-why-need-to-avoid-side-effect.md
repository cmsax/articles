---
title: Simple Reason Why Need to Avoid Side Effect
author: cmsax
date: 2019-05-03
---

## Counterexample

Moments ago I wrote a mutation function in a Vue.js project with side-effect, which means I'd mutated the params.

```typescript
// the mutation function at a glance
[types.MUTATION_NAME](state: State, data: DataInterface) {
  data.foo = newObject
  data.bar = newObject
  ...
}
```

Besides, I `watch` the params passed to the mutation function in the component. Then a infinite loop occurred. ;(

That's why we need to avoid side effect, a simple reason.

