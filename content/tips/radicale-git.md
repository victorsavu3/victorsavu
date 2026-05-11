+++
title = "Backup Radicale to git"
date = 2026-05-10T20:00:00Z
os=["CoreOS"]
tags=["radicale", "git", "forgejo", "podman"]
+++

[Radicale](https://radicale.org/v3.html) allows for [storage hooks](https://radicale.org/v3.html#versioning-collections-with-git) to record changes in git. Getting it working in a container is a bit more involved though. You need:

1. A `.gitconfig`
1. Access to the repository
1. Configuring Radicale

### Set up `.gitconfig`

`git` requires a global `.gitconfig` containing at least a name and email to be able to create commits:

```
[user]
        email = <a@email.address>
        name = <Some name>
```

This needs to be mounted into the container (this example assumes the `root` user):

```
Volume=/var/<somewhere>>/.gitconfig:/root/.gitconfig:Z,ro
```

### Give Radicale access to the repository

`ssh` is not available in the repository, we have to use https. To keep things simple, you can add the user and password to the repository URL itself:

```
git remote add origin https://<user>:<password>@<repository>.git
```

[Forgejo](https://forgejo.org/) supports [repository scoped access tokens](https://forgejo.org/docs/latest/user/token-scope/#specific-repositories) that are ideal in this case (added to version 15). The token must be used instead of the password and can be restricted to a single repository.

For other git hosts, check what is available and avoid storing your actual user password in plaintext.

### Configure Radicale

Add a hook to commit and upload changes to your radicale config:

```
[storage]
hook = git add -A && (git diff --cached --quiet || git commit -m "Changes by \"%(user)s\"") && git push
```
