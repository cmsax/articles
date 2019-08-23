---
title: Integrate InfluxDB Service in GitLab CI
author: Mingshi
date: 2019-08-22
---

The services keyword defines a Docker image that runs during a job linked to the Docker image that the image keyword defines. This allows you to access the service image during build time.

The service image can run any application, but the most common use case is to run a database container, for example:

- MySQL/PostgreSQL/SQLServer
- Redis

GitLab didn't provide an official document for InfluxDB, it still needs to configure though a `service` is just an image.

According to [InfluxDB's official docker image](https://hub.docker.com/_/influxdb), we need to set a few envrionment variables, such as:

- INFLUXDB_DB: for initializing db
- INFLUXDB_ADMIN_USER: for write/read data, relies on the var above

I add a service to a job, following `.gitlab-ci.yml` describes it:

```yaml
# Execute via shell
services:
  - name: influxdb:latest
variables:
  INFLUXDB_DB: "transaction_test"
  INFLUX_DB_HOST: "http://localhost:8086"
# ...
```

However, `Connection Refused` errors occurred when I tried to dial TCP to `localhost` on port `8086` through shell executor in GitLab CI. Port `8086` is influxdb docker image's default HTTP API port.
When defining a `mysql` or `redis` service, no port was described in yaml file, and I successfully connected to `mysql` service via
`localhost:3306`. Is there any difference between these images?

The `mysql` image bind port `3306` by default, yet `influxdb` has not. Besides, GitLab does not support port mapping in CI `service`. There is an [issue](https://gitlab.com/gitlab-org/gitlab-runner/issues/2460) about port mapping in CI `service`, but it's still WIP after 2 years.

To debug, we can run our job on local gitlab-runner, and add `tail -F /dev/null` line before the part where our script fails, this will hault the job for 30 minutes. While it hangs, we can attach to the container wit `docker exec -it container-name /bin/sh` to see what happens. But I'd not try this.

[WIP]
