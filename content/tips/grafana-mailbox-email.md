+++
title = "Use mailbox.org to send emails from Grafana"
date = 2026-07-26T13:55:00Z
tags=["email", "grafana", "mailbox"]
+++

To allow [Grafana](https://grafana.com/) to send emails using [mailbox.org](https://mailbox.org/en/), you need to:

1. Create an email app-password from Settings. It only needs SMTP access, so you can disable IMAP.
1. [Configure Grafana](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#smtp) using `grafana.ini`:

```
[smtp]
enabled=true
host=smtp.mailbox.org:465
user={{SMTP username}}
from_address={{SMTP sender}}
password={{SMTP token}}
```

`{{SMTP username}}` is your main email address. `{{SMTP token}}` is the app-password you created earlier. `{{SMTP sender}}` can be any email if you have a catch-all address. If you don't have a catch-all address, I believe you can use any of your aliases, but I haven't tested it.
