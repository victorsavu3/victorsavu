+++
title = "I'm switching from Proton Calendar to Radicale"
date = 2026-04-03T19:50:00Z

[taxonomies]
tags = ["proton", "radicale"]
+++

I have given up trying to use [Proton Calendar] as my main calendar application due to three big issues:

1. Proton does not use [CalDAV] and on Android, other applications can't read calendars from the Proton Calendar app. To synchronize events on my smartwatch I need to export the calendar to a 3rd party service (Google in my case).
1. To be able to plan things, I need to see my work events in my calendar app. Proton has a quite large [sync delay] for [external calendars], large enough for me to make mistakes.
1. Proton contacts also don't sync with Android (you can [import, but not export]).

To make my life simpler, I've migrated to a self-hosted instance of [Radicale]. I lose the [Proton Mail] app integration, but I can still use [Thunderbird] to manage everything including contacts. On Android I use [DAVx5] to sync everything with much shorter sync delays. I hope [CalDAV Push] will make the delay go completely away once Radicale supports it.

[Proton Calendar]: https://calendar.proton.me
[CalDAV]: https://en.wikipedia.org/wiki/CalDAV
[sync delay]: https://protonmail.uservoice.com/forums/932842-lumo/suggestions/44698060-decrease-sync-delay
[external calendars]: https://proton.me/support/subscribe-to-external-calendar
[import, but not export]: https://proton.me/support/proton-contacts-mobile
[Radicale]: https://radicale.org/v3.html
[Proton Mail]: https://mail.proton.me
[Thunderbird]: https://www.thunderbird.net
[DAVx5]: https://www.davx5.com/
[CalDAV Push]: https://github.com/bitfireAT/webdav-push

### See also

* [Backup Radicale to git](@/tips/radicale-git.md)
* [Override the radicale user when using docker](@/tips/radicale-podman-user.md)
* [Sharing Calendars using Radicale and symlinks](@/tips/radicale-link-share-calendar.md)