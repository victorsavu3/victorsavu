+++
title = "I built a Rust CLI tool without writing a single line of code"
description = "I built and deployed a Rust CLI tool to shuffle Subsonic playlists — complete with a Podman container, systemd integration, and published packages — without writing a single line of code myself."
date = 2026-05-14T09:54:00Z
+++

> [!NOTE]
> This blog post was written by Claude. Like the project itself, not a single word was typed by hand.

I've been self-hosting my music with [Navidrome](https://www.navidrome.org/) for a while now, and one thing that always bothered me was the lack of a good way to shuffle a playlist in place. Subsonic clients can shuffle playback, but the playlist order on the server stays fixed — so if I want a fresh random order I had to do it manually.

So I built [subsonic-shuffler](https://forgejo.victorsavu.eu/victor/subsonic_shuffle): a small Rust CLI that shuffles a Subsonic playlist. It can shuffle in place, write the result to a different playlist, or create a new one. It reads credentials from environment variables and runs as a one-shot Podman container on my CoreOS server, triggered nightly at 3 AM by a systemd timer.

The interesting part: I didn't write a single line of code.

## The experiment

I've been using Claude Code for a while for smaller tasks, but this time I wanted to see how far I could push it on a greenfield project with no existing codebase to guide it. The rules I set for myself: describe what I want, answer clarifying questions, review what gets produced — but never touch the keyboard to write code myself.

The result is a fully working Rust project with:

- A CLI built with `clap`, using the [`opensubsonic`](https://crates.io/crates/opensubsonic) crate for the Subsonic API
- Flexible source/destination options (`--source`, `--source-id`, `--output`, `--output-id`, `--create`)
- Helpful error messages that list matching playlists with their IDs when a name is ambiguous
- A `Justfile` for local development
- A multi-stage `Containerfile` producing a minimal Alpine image
- The image published to my [Forgejo container registry](https://forgejo.victorsavu.eu/victor/-/packages/container/subsonic-shuffler/latest)
- The crate published to my [Forgejo cargo registry](https://forgejo.victorsavu.eu/victor/-/packages/cargo/subsonic-shuffler/1.0.0)
- A Quadlet `.container` file for systemd integration on CoreOS

All of it committed in a git repository with meaningful commit messages — also written by Claude.

## What worked well

The back-and-forth felt natural. I'd describe a feature, Claude would ask clarifying questions when the design wasn't obvious (shuffle in place vs. create new? what happens on ambiguous names?), implement it, verify it compiled, then commit. When I asked for changes — removing a redundant flag, changing error message formatting, adjusting the `--create` semantics — they landed correctly on the first try.

The knowledge of the ecosystem was solid. It looked up the `opensubsonic` crate's actual API on docs.rs before writing code rather than guessing, which meant the implementation was correct from the start.

## What still required my input

Judgment calls that needed context I held: which registry to publish to, what the container image path should be, how the systemd unit should be structured, what `OnCalendar=` value to use for the timer. These aren't things an AI can know — they're decisions about my infrastructure. But once I supplied the answer, execution was immediate and correct.

## Conclusion

For a self-contained tool with a clear spec, AI-assisted development is genuinely useful — not as autocomplete, but as a collaborator that can take a description and produce a working, well-structured result. The limiting factor wasn't the code; it was me articulating what I actually wanted.

The source is at [forgejo.victorsavu.eu/victor/subsonic_shuffle](https://forgejo.victorsavu.eu/victor/subsonic_shuffle) if you want to use it or read through what was generated.
