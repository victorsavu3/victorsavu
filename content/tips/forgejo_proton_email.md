+++
title = "Use Proton to send emails from Forgejo"
date = 2026-02-15
tags=["email", "forgejo"]
+++

To allow [Forgejo](https://forgejo.org/) to send emails using [Proton](https://proton.me), you need to:

1. Create an SMTP token in Proton from [settings](https://account.proton.me/u/0/mail/imap-smtp).
1. [Configure Forgejo](https://forgejo.org/docs/latest/admin/setup/email/) using `app.ini`:

```
[mailer]
ENABLED = true
FROM           = {{SMTP username}}
PROTOCOL       = smtp+starttls 
SMTP_ADDR      = smtp.protonmail.ch
SMTP_PORT      = 587
USER           = {{SMTP username}}
PASSWD         = `{{SMTP token}}`
```

Where `{{SMTP username}}` and `{{SMTP token}}` should be copied from Proton.