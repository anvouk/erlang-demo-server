# myappRebar

Demo erlang/otp/rebar3 application.

Tested on otp 22.

Features:
- basic http rest server with cowboy.
- lager logging (with custom config).
- dev mode.

Todo:
- add release mode.
- release config.
- docker support.
- database read/write example.
- more http routes.

## Build

```bash
rebar3 compile
```

## Dev mode

```bash
rebar3 shell
```
