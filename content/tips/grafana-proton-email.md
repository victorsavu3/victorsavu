+++
title = "Use Proton to send emails from Grafana"
date = 2026-04-22T20:30:00Z
tags=["email", "grafana", "proton"]
+++

To allow [Grafana](https://grafana.com/) to send emails using [Proton](https://proton.me), you need to:

1. Create an SMTP token in Proton from [settings](https://account.proton.me/u/0/mail/imap-smtp).
1. [Configure Grafana](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#smtp) using `grafana.ini`:

```
[smtp]
enabled=true
host=smtp.protonmail.ch:587
user={{SMTP username}}
from_address={{SMTP username}}
startTLS_policy=MandatoryStartTLS
password={{SMTP token}}
```

Where `{{SMTP username}}` and `{{SMTP token}}` should be copied from Proton.