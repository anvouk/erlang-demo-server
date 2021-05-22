-module(myappRebar_cowboy_middleware_logger).

-behaviour(cowboy_middleware).

-export([execute/2]).

-spec execute(Req :: cowboy_req:req(), Env :: cowboy_middleware:env()) ->
    {ok, Req :: cowboy_req:req(), Env :: cowboy_middleware:env()}
    | {suspend, Module :: any(), Function :: any(), Args :: any()}
    | {stop, Req :: cowboy_req:req()}.
execute(Req, Env) ->
    lager:info("~s ~s - ~s", [cowboy_req:method(Req), cowboy_req:path(Req), cowboy_req:host(Req)]),
    {ok, Req, Env}.
