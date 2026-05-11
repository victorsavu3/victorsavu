+++
title = "Override the radicale user when using docker"
date = 2026-04-03T18:40:00Z
tags=["radicale", "podman"]
+++

The [Radicale] [Dockerfile] hardcodes `1000` as the UID running inside the container. If that user is not available, it can still be overridden. If using [quadlet] You can add `User=<your choice>` to the `[Container]` section. The [podman] or [docker] CLI equivalent is `--user <your choice>`.

[Radicale]: https://radicale.org/v3.html
[Dockerfile]: https://github.com/Kozea/Radicale/blob/master/Dockerfile
[quadlet]: https://docs.podman.io/en/latest/markdown/podman-quadlet.1.html
[podman]: https://podman.io/
[docker]: https://www.docker.com/products/cli/
