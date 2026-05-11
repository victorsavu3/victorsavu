+++
title = "Forgejo is now live"
date = 2026-03-07T20:00:00Z
tags = ["launch", "forgejo", "coreos"]
+++

### TL;DR: [Forgejo is live](https://forgejo.victorsavu.eu/), [Website code here](https://forgejo.victorsavu.eu/victor/victorsavu)

### Forgejo

I like [git](https://git-scm.com/) and good UIs to review changes, so I use [Forgejo](https://forgejo.org/). This setup took a while since I got sidetracked with [SSH passthrough](https://forgejo.org/docs/latest/admin/installation/docker/#ssh-passthrough), which I never got working on [CoreOS](https://fedoraproject.org/coreos/). But now, by using the built-in SSH server and a [moved sshd port](@/tips/sshd-port-coreos.md) I have a working forgejo instance 🎉.

### This website

This website is built using Zola and completely static. You can now [read the source code](https://forgejo.victorsavu.eu/victor/victorsavu), [including all the history](https://forgejo.victorsavu.eu/victor/victorsavu/commits/branch/main). Everything is intended to be public so let's show the world how the sausage is made.

### Other projects

I'm slowly migrating from an older Forgejo instance (which started as [Gitea](https://about.gitea.com/)) to this one, expect more repositories to show up soon. Most of them are private though.

### See also

* [Use Proton to send emails from Forgejo](@/tips/forgejo-proton-email.md)
* [Change the SSHD port in Fedora CoreOS](@/tips/sshd-port-coreos.md)
