+++
title = "Serve precompressed static files from caddy"
date = 2026-03-07T12:00:00Z

[taxonomies]
tags = ["caddy", "compression", "precompress"]
+++

## Background

While [Caddy](https://caddyserver.com/) can [compress files](https://caddyserver.com/docs/caddyfile/directives/encode) as they are requested, my website is completely static (built using [Zola](https://www.getzola.org/) )and all of this work can be done once ahead of time. For this purpose I use [precompress](https://github.com/ryanfowler/precompress).

To make everything work, Caddy needs to be instructed to look for precompressed files:

```caddy
file_server {
    precompressed
}
```

To actually precompress, you just need to install and point `precompress` at the right folder. The default options work well for me.

```shell
cargo install precompress
~/.cargo/bin/precompress {{your site folder}}
```

I use a [justfile](https://just.systems/man/en/) to manage building and deploying my website, which lets me do everything in a one-liner:

```justfile
build:
    rm -rf public
    ~/.cargo/bin/zola build
    ~/.cargo/bin/precompress public

install-deps:
    cargo install --locked --git https://github.com/getzola/zola
    cargo install precompress

deploy-victorsavu: build
    rsync -rzP --delete public/ victorsavu@victorsavu.eu:victorsavu/
```
