---
title: Hybrid Cloud Across IPsec VPN Tunnel
author: Mingshi
date: 2019-05-30
---

## Tutorial

- Install IPsec VPN on public cloud machine.
- Connect the router in LAN to the VPN.
- Configurate gateway in the cloud machine.
- Setup NGINX on the cloud machine.
- Add server conf file to `/etc/nginx/sites-enabled/` and write it in your way.
- Reload your NGINX server and visit the URL to see what happens.

## NGINX Conf Demo

```
server {
        listen 80;
        server_name api.contoso.com;
        location / {
                proxy_pass http://192.168.0.70:8848;
                proxy_set_header Host $http_host;
        }
}
```

## Tips

- Ubuntu saves your life not centOS.
