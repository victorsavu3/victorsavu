+++
title = "How I manage my music"
description = "Detailed documentation of how I manage my music collection."
date = 2026-09-22T18:00:00Z

[taxonomies]
tags = ["music", "subsonic-duplicates", "subsonic-shuffler"]
+++

## Introduction

For more than 5 years, I moved away from music streaming services to my own self-hosted solution. In this blog post I document my setup both for myself and for anyone looking for inspiration on how to get started or how to manage a sizable collection.

As of `2026-09-22` I've collected 3.4 weeks of music, 9155 tracks from 3446 artists in 328 albums with a size of 210.3 GiB. 1140[^duplicates] tracks are [duplicated](#handling-duplication) between albums.

## Why lossless

The lossless music debate has been ongoing for decades and there are many great arguments from both sides. Personally I chose lossless for one simple reason: I don't want to be tied down to a single format. Converting between lossy formats makes the errors compound and unless you are willing to stay with your original format, you will, over the decades, lose quality.

I currently use [Flac] to store my music at a survivable compression ratio of about 2:1. If a considerably better lossless encoder shows up, there's nothing stopping me from converting all of my music to it without any quality loss (and I really hope one shows up before my collection can't fit on my laptop anymore).

There are many more lossy music formats and I also use them. The most popular lossless format, [MP3] is supported by pretty much everything. My current favorite format, [Opus][^opus], was only released in 2012 and is still evolving. I already use both formats and like that I can re-encode my music without loss. 

## Where I get my music

#### TL;DR

CDs are usually cheaper. Look at:

1. [Amazon] (CDs)
1. [medimops] (Used CDs)
1. [Qobuz] (Digital downloads)

#### How I started

For a long time I didn't have my own music collection. I cheated by using online services like [Pandora][^pandora], [Youtube] or [Spotify]. That means I started from scratch. I live in Germany, but most of the pros and cons apply anywhere from what I can tell.

To get gong, I found a few boxes of used CDs on [eBay] (they even have a category for it). That gave me a great starting point for my setup while not being that expensive. I spent less than €100 to get a few hundred hours of music.

### How it's going

To always have "new" music I budget €20 every month to buy music. It is more expensive than a streaming subscription, but I do get to keep all of my music forever. I have a running wishlist of tracks and albums and pick things from there that fit into the budget. Most of the times, I pick something that's on sale.

My main sources of music are now:

1. [Amazon] (CDs)
    * My main source of recent CD releases
    {% li(class="positive") %}Great selection, always has popular recent releases{% end %}
    {% li(class="positive") %}A wishlist can help find deals{% end %}
    * Has autorip which gives you mp3 versions of some CDs (never used it).
    {% li(class="negative") %}Prices are sometimes inflated{% end %}
2. [Qobuz] (Digital downloads)
    * My main source of lossles digital music
    {% li(class="positive") %}Great selection, most releases can be found here (old and new){% end %}
    {% li(class="positive") %}Let's you download well tagged flac files{% end %}
    {% li(class="negative") %}Almost always more expensive than CDs{% end %}
    {% li(class="negative") %}Higher quality release are even more expensive{% end %}
3. [medimops] (Used CDs)
    * My main used source of used CDs (mostly older releases that are hard to find new)
    {% li(class="positive") %}Amazing selection{% end %}
    * Often the seller of used CDs on Amazon, ordering directly is cheaper
    {% li(class="negative") %}CDs are used{% end %}
        * CD quality is not always guarateed. I haven't had completely unreadable disks yet, but some were a struggle to rip.
4. [Bandcamp] (Digital downloads)
    * Smaller bands just release their music on Bandcamp and it's definitely the right place to get it.
    {% li(class="positive") %}Pay artists directly{% end %}
    {% li(class="positive") %}Amazing prices{% end %}
    {% li(class="negative") %}Can't find most well-known bands and artists here{% end %}

Buying digitally is the most convenient, no contest. You get the music files and are done. But for reasons that elude me, the digital version of albums is almost always more expensive than buying the CD new (with shipping). Many times it's twice the cost. I still check [Qobuz] first just in case I can skip the plastic and extra hassle of CDs. If you find a great source of **lossless** digital releases, send them to me at [music@victorsavu.eu](mailto:music@victorsavu.eu). I have been looking for options, but nothing I found beats [Qobuz].

## Managing and tagging my library

To manage my library I use [Beets]. What sold me on it as a solution is the import process; Just [try it] and see if it works for you.

My process to add music:

1. If it's a CD: Rip it with [fre:ac]
1. If autotagging does not work: Manually tag the files using [Quod Libet]
1. Put the files in a [git-annex] archive to have a known good copy
1. Import using [Beets]. Most of the heavy lifting is done here
    * autotagging to fix up the tags
    * replaygain analysis and tagging
    * Creating the folder structure and putting the files in the right place
    * The music is now ready
1. If the autotagger doesn't work: Try to find the album in [MusicBrainz] by hand
1. If the release is not in [MusicBrainz]: Double check the tags and import as is
1. Wait for [Syncthing] to propagate the changes everywhere

I've used my archive only once quite early in my process to start from scratch. Since then, I've only made updates to the config and tags and had Beets deal with it quite successfully. The only manual cleanup in the folder structure was to sometimes move the cover image when Beets lost track of it due to album structure changes.

[try it]: https://beets.io/blog/walkthrough.html

#### Handling duplication

As far as I can tell, there is no way to handle duplicated tracks in your collection without removing files from your collection. What counts as a duplicate is not obvious, but for example, I count radio mixes (shorter versions) of songs as duplicates. Which version is the canonical one also depends on my preference and is not consistent.

To help with this I created my own tool, [subsonic-duplicates], to deal with it. It finds duplicates using heuristics based on tags and let's me chose the canonical version. Matches can also by added manually (sometimes tracks have completely different names in different albums). Unless you want the same flexibility I do when dealing with duplicates, you should try to find something else.

## Accessing music

I strongly recommend [Navidrome] since for me it just works. It's running in a container on my NAS with [Syncthing] creating a read-only copy of the music files for Navidrome to use.

If I really want access to the music files, I can just share them with [Syncthing]. It works, but I've not used it for a while.

If file size or bandwith are a concern, Navidrome can convert files on the fly. I managed to listen to music on my phone using [Opus] while using amazingly little data.

## Playing music

Since [Navidrome] is available from anywhere and can play music via a [OpenSubsonic] client or the website itself. 

On desktop, I prefer [Feishin] installed as a local application over the website, it has more features than the website and music playback is more stable. Both Chrome and Firefox like to reduce performance of inactive tabs and the music starts stuttering after some time. Feishin can also edit smart playlists, which makes using them in Navidrome much easier.

On the go, I mostly use my phone with [DSub2000]. Since I don't always have access to the internet (for example on an airplaine), offline playback is important to me. DSub2000 has an offline cache and can even upload scrobbles when network becomes available. I have also tried [Symfonium], which has much more advanced cache controls and in general more features, but had issues with sporadic offline playback (where network access is intermittent). It is also much more complex to configure compared to DSub2000, which only does one thing.

At home, I also use [Music Assistant] to play music on our TV connected to a good speaker setup. It also uses [Navidrome] to access my entire collection and works quite well (including scrobbles). This is also my soft alarm in the morning, it's nice to have music start up automatically. See [subsonic-shuffler](@/blog/subsonic-shuffler.md) for the script that I use to shuffle the alarm playlist.

To go old-school, I also own a [HiBy R3 II] to have a disctraction-free music experience on the go. It works great, but syncrhonizing music is a pain and it's impossible to track scrobbles. If I ever get the chance, I want to get [Rockbox] running on a device again (I used it many moons ago) and setting up a sync from its `.scrobbler.log` to [Navidrome].

For fun, I also have a CD player[^cd-player] that supports [MP3]. I sometimes pop in one of my CDs or create a mix CD from one of my playlists. This is the least practical, but most purist way to enjoy my music.

[^duplicates]: Based on my manual curation.
[^opus]: I can't tell the difference between Opus and Flac at a target bitrate of 96kbps. MP3 is still noticeable for me at 128kbps.
[^pandora]: I'm still sad that the service is no longer available in Germany.
[^cd-player]: I own a [Lenco CD-500], but it's not something I would recommend

[Navidrome]: https://www.navidrome.org/
[Feishin]: https://github.com/jeffvli/feishin
[Beets]: https://beets.io/
[fre:ac]: https://www.freac.org/
[Syncthing]: https://syncthing.net/
[DSub2000]: https://github.com/paroj/DSub2000
[Symfonium]: https://www.symfonium.app/
[Music Assistant]: https://www.music-assistant.io/
[Rockbox]: https://www.rockbox.org/
[git-annex]: https://git-annex.branchable.com/
[Quod Libet]: https://quodlibet.readthedocs.io/en/latest/
[subsonic-duplicates]: https://forgejo.victorsavu.eu/victor/subsonic-duplicates

[MusicBrainz]: https://musicbrainz.org/
[MP3]: https://en.wikipedia.org/wiki/MP3
[Opus]: https://opus-codec.org/
[Flac]: https://xiph.org/flac/

[Amazon]: https://www.amazon.de/-/en/gp/browse.html?node=255882
[Qobuz]: https://www.qobuz.com/de-de/shop
[medimops]: https://www.medimops.de/musik-C0255882/
[eBay]: https://www.ebay.de/b/Cd-Konvolut/176984/bn_7005332258
[Bandcamp]: https://bandcamp.com/

[Pandora]: https://www.pandora.com
[Youtube]: https://youtube.com/
[Spotify]: https://spotify.com/

[HiBy R3 II]: https://store.hiby.com/products/hiby-r3-ii?variant=43922642534616
[Lenco CD-500]: https://www.amazon.de/-/en/dp/B0CBDKVH8M

[OpenSubsonic]: https://opensubsonic.netlify.app/
