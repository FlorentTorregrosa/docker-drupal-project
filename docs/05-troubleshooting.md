# Troubleshooting

## File permissions

If you have a file permission issue, execute:

```bash
./scripts/fix-permissions-dev.sh
```

Warning: use this script only if you are on a dev environment and execute it as
root. If you are using it inside the DOcker container you are already root.

## Xdebug breakpoint not taken into account

Try either or both:
* in `conf/php/php.ini`: change `opcache.revalidate_freq` and set it to 5 per
example.
* in `docker-compose.yml`: remove the `:delegated` of some volumes like
`- .:/project:delegated`
