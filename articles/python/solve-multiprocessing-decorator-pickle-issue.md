---
title: Solve Pickle Issue When Using Function with Decorator in Multiprocessing
author: Mingshi
date: 2019-04-26
---

## Issue

Exceptions raised below when I tried to use function with function decorator in multiprocessing.

### My Decorator

```python
def wrapped(retry=5, with_client=False):
    def decorator(func):
        @wraps
        def wrapper(*args, **kwargs):
            nonlocal retry
            while True:
                try:
                    if with_client:
                        client = InfluxDBClient(**kwargs['influx_option'])
                        func(client, *args, **kwargs)
                    else:
                        func(*args, **kwargs)
                except Queue.empty:
                    time.sleep(1)
                    if retry < 0:
                        print('Exit {} after retry.'.format(func.__name__))
                    retry -= 1
                except Queue.full:
                    time.sleep(1)
                except Exception as e:
                    print('Exception raised in {}'.format(func.__name__))
                    print(str(e))
                    time.sleep(1)
        return wrapper
    return decorator
```

I use this decorator function this way:

```python
from multiprocessing import Process
# ...

@wrapped(4)
run(arg):
    pass

Process(target=run, args=('test',)).start()
```

### Errors

```bash
# 1st error
AttributeError: Can't pickle local object 'wrapped.<locals>.decorator.<locals>.wrapper'

# 2nd error
EOFError: Ran out of input
```

## Solution

The reason this happens is that a wrapped function with function decorator is not `picklable`, which means the wrapped function is not serializable when passed to `Process()`, view [this blog](http://ralph-wang.github.io/blog/2015/02/15/zhuang-shi-qi-yu-duo-jin-cheng-yi-ji-pickle/)(language: zh-CN).

You can implement a decorator class to return a `picklable` object instead of decorator function.

### My New Decorator

```python
class Wrapped(object):
    def __init__(self, retry=5, with_client=False):
        self.retry = retry
        self.with_client = with_client

    def __call__(self, func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            while True:
                try:
                    if self.with_client:
                        client = InfluxDBClient(**kwargs['influx_option'])
                        func(client=client, *args, **kwargs)
                    else:
                        func(*args, **kwargs)
                except Queue.empty:
                    time.sleep(1)
                    if retry < 0:
                        print('Exit {} after retry.'.format(
                            func.__name__
                        ))
                        break
                    retry -= 1
                except Queue.full:
                    time.sleep(1)
                except Exception as e:
                    print('Exception raised in {}'.format(
                        func.__name__
                    ))
                    print(str(e))
                    time.sleep(1)
        return wrapper
```

Now, we use the decorator class this way:

```python

@Wrapped(4, True)
run(arg):
    pass

Process(target=run, args=(arg, ))
```

