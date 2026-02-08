+++
title = "Limiting deSEC tokens for DNS-01 and dynDNS"
date = 2026-02-08
tags=["dns", "desec"]
+++

The [deSEC documentation](https://desec.readthedocs.io/en/latest/auth/tokens.html#token-scoping-policies) documents how to scope tokens using policies. I used this feature to limit my deSEC tokens to what they are responsible for.

> [!NOTE]
> The `{{id}}` is not the token name and is unfortunately not shown in the UI. See [useful commands below](#useful-commands) for a simple way to query the ids of all your tokens.

I use [just](https://just.systems/man/en/) to organize my commands. If you want the commands to work in your shell, just replace `{{something}}` with `${something}`.

#### dynDNS

I use dynDNS since I don't have a static IP at home. This allows updating both A and AAAA records, but only for the intended domain and subdomain. For each domain, I use a different token to keep things safer.

```just
desec-limit-token-dyndns id domain subdomain: 
    curl -sS  https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/ \
       --header "Authorization: Token ${DESEC_TOKEN}" \
       --header "Content-Type: application/json" --data @- <<< \
       '{"domain": null, "subname": null, "type": null, "perm_write": false}'
    curl -sS  https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/ \
       --header "Authorization: Token ${DESEC_TOKEN}" \
       --header "Content-Type: application/json" --data @- <<< \
       '{"domain": "{{domain}}", "subname": "{{subdomain}}", "type": "AAAA", "perm_write": true}'
    curl -sS  https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/ \
       --header "Authorization: Token ${DESEC_TOKEN}" \
       --header "Content-Type: application/json" --data @- <<< \
       '{"domain": "{{domain}}", "subname": "{{subdomain}}", "type": "A", "perm_write": true}'
```

#### ACME DNS-01

I use wildcard certificates, which can only be issued by using a [DNS-01 challenge](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge). This only allows updating the `_acme-challenge` with a `TXT` record only, which is enough for the challenge.

```just
desec-limit-token-acme id domain: 
    curl -sS https://desec.io/api/v1/auth/tokens/{{id}}/ --header "Authorization: Token ${DESEC_TOKEN}" | jq .name
    curl -sS  https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/ \
       --header "Authorization: Token ${DESEC_TOKEN}" \
       --header "Content-Type: application/json" --data @- <<< \
       '{"domain": null, "subname": null, "type": null, "perm_write": false}'
    curl -sS  https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/ \
       --header "Authorization: Token ${DESEC_TOKEN}" \
       --header "Content-Type: application/json" --data @- <<< \
       '{"domain": "{{domain}}", "subname": "_acme-challenge", "type": "TXT", "perm_write": true}'
```

#### Useful commands

```just
desec-list-tokens:
    curl -sS https://desec.io/api/v1/auth/tokens/ --header "Authorization: Token ${DESEC_TOKEN}" | jq '.[] |{name, id}'

desec-list-policies id:
    curl -sS https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/ --header "Authorization: Token ${DESEC_TOKEN}" | jq

desec-delete-policy id policy_id:
    curl -sS  -X DELETE https://desec.io/api/v1/auth/tokens/{{id}}/policies/rrsets/{{policy_id}}/ \
       --header "Authorization: Token ${DESEC_TOKEN}"
```