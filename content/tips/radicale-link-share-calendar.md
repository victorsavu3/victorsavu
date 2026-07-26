+++
title = "Sharing Calendars using Radicale and symlinks"
date = 2026-04-03T19:00:00Z

[taxonomies]
tags = ["radicale", "podman"]
+++

While [Radicale] now [supports sharing], an older and very simple way to make it work is to just use symlinks. Here I assume `user1` wants to share their `planning` calendar with `user2` with full permissions. 

```
cd <path to collection-root>/user2
ln -s ../user1/planning/ user1_planning
```

[Radicale]: https://radicale.org/v3.html
[supports sharing]: https://github.com/Kozea/Radicale/wiki/Sharing-Collections
