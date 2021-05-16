-module(myappRebar_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    lager:start(),
    Dispatch = cowboy_router:compile([
        %% {HostMatch, list({PathMatch, Handler, InitialState})}
        {'_', [
            {"/api/[:id]", hello_handler, []}
        ]}
    ]),
    %% otp 21+ speedup
    persistent_term:put(my_app_dispatch, Dispatch),
    %% Name, TransOpts, ProtoOpts
    {ok, _} = cowboy:start_clear(my_http_listener, [{port, 8080}], #{
        env => #{dispatch => {persistent_term, my_app_dispatch}}
    }),
    lager:info("application started"),
    myappRebar_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(my_http_listener).
