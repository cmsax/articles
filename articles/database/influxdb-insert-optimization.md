---
title: Optimize InfluxDB Data Insertion
date: 2019-04-18
---

## Issue Description

We know that InfluxDB can query time series data more efficiently than SQL databases,
but there are still some bugs when we insert or query data, they are:

- SQL can return a result eventually even if it costs lots of time, but InfluxDB sometimes
does return empty result set.
- Data in InfluxDB might be lost and we can find it back by `backup & import`.
- InfluxDB over Nginx or other HTTP server may encounter various problem such as `504 gateway time-out`.

Besides, importing data to InfluxDB is really slow. UDP is fast, but it's not reliable for this case.

## Solutions

To optimize the process of importing data, we can do these things.

- Add more memory to your server.
- Set the HTTP server's `time-out` and `max request size` to avoid
`gateway timeout` or other HTTP server badcode.
- Using agent server like Nginx will make double-transfer your data packet,
because request data is first sent to Nginx, and Nginx will not transfer your
request data until it take over the request body.
- Do not split your request to batches as possible as you can.
- Dump your data to import and not use HTTP request.

