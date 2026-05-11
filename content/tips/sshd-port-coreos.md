+++
title = "Change the SSHD port in Fedora CoreOS"
date = 2026-03-07T19:00:00Z
updated = 2026-03-08T08:30:00Z
tags=["coreos", "selinux", "sshd"]
+++

Changing the port of sshd in [CoreOS](https://fedoraproject.org/coreos/) is not obvious. There are multiple open bugs ([1](https://github.com/coreos/fedora-coreos-tracker/issues/1022), [2](https://github.com/coreos/fedora-coreos-tracker/issues/396)) for this issue and I believe I have found a new approach that works for my server. The [old CoreOS instructions](https://github.com/coreos/docs/blob/master/os/customizing-sshd.md), don't take SELinux into account, they just update the `sshd` configuration. The [Flatcar documentation](https://www.flatcar.org/docs/latest/setup/security/customizing-sshd/) is almost identical.

### 1. Configure `sshd.service` and `sshd.socket`

```yaml
storage:
  files:
    - path: /etc/ssh/sshd_config.d/port.conf
        contents:
            inline: Port 2223
        mode: 0644
```

```yaml
systemd:
  units:
    - name: sshd.socket
        dropins:
        - name: sshd-port.conf
            contents: |
            [Socket]
            ListenStream=
            ListenStream=2223
```

### 2. Make selinux happy

Just updating sshd is not enough, it will not have the permissions to bind to any port besides what is set as `ssh_port_t`. So, let's update that using a [cil policy to update the label](https://github.com/SELinuxProject/cil/wiki/#network-labeling):

```yaml
systemd:
  units:
    - name: custom-ssh-port-t.service
      enabled: true
      contents: |
        [Unit]
        Description=Update ssh_port_t
        Before=sshd.service

        [Service]
        Type=oneshot
        ExecStart=/usr/sbin/semodule -i /root/ssh_port_t.cil
        RemainAfterExit=yes

        [Install]
        WantedBy=multi-user.target
```

```yaml
storage:
  files:
    - path: /root/ssh_port_t.cil
      mode: 0644
      contents:
        inline: |
          (portcon tcp 2223 (system_u object_r ssh_port_t ((s0)(s0))))
```

### Alternatives that didn't work for me

* Adding a custom SELinux policy. It only worked if I installed it with `selinux -i`.
  * I did manage to deploy a `pp` file that showed up in `semodule --list-modules`, but never took effect at both low or high priorities.
* Changing `ssh_port_t` using `semanage`, but it's not installed in CoreOS.

