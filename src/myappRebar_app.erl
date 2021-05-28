-module(myappRebar_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        % {HostMatch, list({PathMatch, Handler, InitialState})}
        {'_', [
            {"/api", myappRebar_handler_api, []}
        ]}
    ]),
    {Port, _} = string:to_integer(os:getenv("HTTP_PORT", "8080")),
    % otp 21+ speedup
    persistent_term:put(my_app_dispatch, Dispatch),
    % Name, TransOpts, ProtoOpts
    {ok, _} = cowboy:start_clear(my_http_listener, [{port, Port}], #{
        env => #{dispatch => {persistent_term, my_app_dispatch}},
        stream_handlers => [cowboy_compress_h, cowboy_stream_h],
        middlewares => [
            cowboy_router,
            myappRebar_cowboy_middleware_helmet,
            cowboy_handler,
            myappRebar_cowboy_middleware_logger
        ]
    }),
    lager:notice("server listening at http://localhost:~p", [Port]),
    myappRebar_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(my_http_listener).
