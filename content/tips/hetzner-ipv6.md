+++
title = "Enable ipv6 on a Hetzner CoreOS server"
date = 2026-01-17T14:00:00Z

[taxonomies]
os = ["CoreOS"]
tags = ["ipv6", "quadlet"]
+++

[Hetzner](https://hetzner.com) automatically assigns an ipv6 range to each server, but it does **not** assign an ipv6 address to it. This must be done manually for [CoreOS](https://fedoraproject.org/coreos/) by updating the network configuration in `/etc/NetworkManager/system-connections/enp1s0.nmconnection` to:

```
[connection]
id=enp1s0
type=ethernet
interface-name=enp1s0
uuid=f141878f-5566-303c-8231-1c1ab23f2256

[ipv4]
method=auto
dns=8.8.8.8,8.8.4.4

[ipv6]
method=manual
addresses=<your range here>::1/64,fe80::1
gateway=fe80::1
dns=2001:4860:4860::8888,2001:4860:4860::8844
may-fail=false
```

For DNS (both ipv4 and ipv6) I picked [Google DNS](https://developers.google.com/speed/public-dns/docs/using).

This configuration was based on the [Hetzner documentation on ipv6](https://docs.hetzner.com/cloud/servers/primary-ips/primary-ip-configuration/).

See also: [Use direct ipv6 when possible and a fallback for ipv4](@/tips/cheat-ipv6.md)