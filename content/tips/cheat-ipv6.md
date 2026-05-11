+++
title = "Use direct ipv6 when possible and a fallback for ipv4"
date = 2026-01-17T10:00:00Z
tags=["ipv6", "dns", "tls", "caddy"]
+++

## Background

My network provider only provides me an ipv6 address and uses [DS-Lite](https://fritz.com/en/apps/knowledge-base/FRITZ-Box-7590/1611_What-is-DS-Lite-and-how-does-it-work) for outgoing ipv4 connections. This means I can't host something on my home-network and have it accessible from all networks.

To get around this I have a funky setup that allows direct connections over ipv6 and proxies all ipv4 through a server that does have an ipv4 address (I use the cheapest [Hetzner](https://hetzner.com) server for this). Most networks support ipv6 and a direct connection is used and I don't have to pay for bandwidth. The server is only involved in ipv6 connections.

## Setup

* Home server (called `homeserver`). The server we want to reach from everywhere.
* Cloud server (called `cloudserver`). A cheap server that has a public ipv4 address.
* Client (who wants to connect to `homeserver`) from a different network.
* DynDNS provider
    * Must allow updating only `AAAA` entries without touching `A`. [DeSEC](https://desec.readthedocs.io/en/latest/dyndns/update-api.html#determine-ip-address-es) allows this by passing `myipv4=preserve`.

### DNS setup

`home.victorsavu.eu`
    `A` - Cloud server ipv4 address - static
    `AAAA` - Home server ipv6 address - DynDNS

`home6.victorsavu.eu`
    `AAAA` - Home server ipv6 address - DynDNS

### Homeserver

`homeserver` uses curl to periodically update the AAAA DynDNS entries in `home6.victorsavu.eu` and `home.victorsavu.eu`. It has no other special restrictions.

### Caddy proxy running on `cloudserver`

```
*.victorsavu.com {
        tls {
            dns <your provider> {
                <provider config>
            }
        }

        @redirected `host('home.victorsavu.eu')`
        handle @redirected {
                reverse_proxy home6.victorsavu.eu
        }

        # Fallback for otherwise unhandled domains
        handle {
                respond 421
        }
}
```

We use Caddy to proxy ipv4 connections from clients connecting over ipv4 to `homeserver`. Since it can't respond to all http requests (All ipv6 requests go directly to `homeserver`), we can't use the [`http-01`](https://letsencrypt.org/docs/challenge-types/#http-01-challenge) challenge here and need to use something like [`dns-01`](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge) instead. `dns-01` also allows obtaining a wildcard certificate. You can proxy as many subdomains as you need with this setup (I use 4 for example). Additional domains just need to be added to the `@redirected`: `host('home.victorsavu.eu', 'second.victorsavu.eu')`.