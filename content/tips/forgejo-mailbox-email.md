+++
title = "Use mailbox.org to send emails from Forgejo"
date = 2026-07-26T13:51:00Z
tags=["email", "forgejo", "mailbox"]
+++

To allow [Forgejo](https://forgejo.org/) to send emails using [mailbox.org](https://mailbox.org/en/), you need to:

1. Create an email app-password from Settings. It only needs SMTP access, so you can disable IMAP.
1. [Configure Forgejo](https://forgejo.org/docs/latest/admin/setup/email/) using `app.ini`:

```
[mailer]
ENABLED   = true
FROM      = {{SMTP sender}}
PROTOCOL  = smtps
SMTP_ADDR = smtp.mailbox.org
SMTP_PORT = 465
USER      = {{SMTP username}}
PASSWD    = {{SMTP token}}
```

`{{SMTP username}}` is your main email address. `{{SMTP token}}` is the app-password you created earlier. `{{SMTP sender}}` can be any email if you have a catch-all address. If you don't have a catch-all address, I believe you can use any of your aliases, but I haven't tested it.
