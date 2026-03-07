+++
title = "Add modules to caddy on CoreOS"
date = 2026-01-17T12:00:00Z
os=["CoreOS"]
tags=["caddy", "quadlet"]
+++

Some [Caddy](https://caddyserver.com/) modules are [non-standard](https://caddyserver.com/docs/modules/) and are not included in the official docker image. You can add modules easily using [`xcaddy`](https://github.com/caddyserver/xcaddy), but you need to create a custom docker image each time. This can be done in CoreOS using `.build` files.

Create a `Containerfile` that builds the image. In this example we add `caddy-dns/desec` to the image and we install the file as `/etc/containers/systemd/Containerfile.caddy`.

```dockerfile
FROM docker.io/library/caddy:2-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/desec

FROM docker.io/library/caddy:2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
```

> [!NOTE]
> Use the full image path `docker.io/library/caddy`.

To add the build file to quadlet, you need to create `/etc/containers/systemd/caddy.build`.

```systemd
[Unit]
Description=Build custom Caddy image with deSEC DNS

[Build]
SetWorkingDirectory=.
File=Containerfile.caddy
ImageTag=localhost/caddy-desec
```

> [!NOTE] 
> Note: `SetWorkingDirectory` is required and also let's you put the `Containerfile` somewhere else. 

Your `caddy.container` now needs to reference the `caddy.build` image by adding

```systemd
[Container]
ContainerName=caddy
Image=caddy.build
```