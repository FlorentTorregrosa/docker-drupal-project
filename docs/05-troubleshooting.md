# Troubleshooting

## File permissions

If you have a file permission issue, execute:

```bash
./scripts/fix-permissions-dev.sh
```

Warning: use this script only if you are on a dev environment and execute it as
root. If you are using it inside the DOcker container you are already root.

## Xdebug breakpoint not taken into account (while it was working)

Try either or both:
* in `.env`: change `CUSTOM_PHP_OPCACHE_REVALIDATE_FREQ` and set it to 5 per
example and restart your environment.
* in `docker-compose.yml`: remove the `:delegated` of some volumes like
`- .:/project:delegated`
