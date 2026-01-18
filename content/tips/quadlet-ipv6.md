+++
title = "Enable ipv6 in a quadlet container"
date = 2026-01-17
os=["CoreOS"]
tags=["ipv6", "quadlet"]
+++

In podman, the default network has ipv6 disabled. To fix this, create `/etc/containers/systemd/main.network` which just enables ipv6:

```systemd
[Network]
IPv6=true
```

All containers will then need to add a `Network` entry in their config:

```systemd
[Container]
Network=main.network
...
```