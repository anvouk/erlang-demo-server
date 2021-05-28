# myappRebar

Demo erlang/otp/rebar3 application.

Tested on otp 22.

Features:
- basic http rest server with cowboy.
    - compression support
    - logging middleware
    - pseudo helmet middleware
    - env configurable http port
- html templates via erlydtl dependency
    - home page
    - demo login page
    - demo login form handling
    - static files serving
- lager logging (with custom config)
- http request to json backend
- json handling
- dev mode
- erlang formatter (rebar3 fmt)

Todo:
- add release mode.
- release config.
- docker support (?).
- database read/write example (via orm).

## Build

```bash
rebar3 compile
```

## Dev mode

```bash
rebar3 shell
```

## Format code

```bash
rebar3 fmt
```
