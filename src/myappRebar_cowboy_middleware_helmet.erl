-module(myappRebar_cowboy_middleware_helmet).

-behaviour(cowboy_middleware).

-export([execute/2]).

-spec execute(Req :: cowboy_req:req(), Env :: cowboy_middleware:env()) ->
    {ok, Req :: cowboy_req:req(), Env :: cowboy_middleware:env()}
    | {suspend, Module :: any(), Function :: any(), Args :: any()}
    | {stop, Req :: cowboy_req:req()}.
execute(Req, Env) ->
    NewReq = cowboy_req:set_resp_headers(
        #{
            <<"X-Content-Type-Options">> => <<"nosniff">>,
            <<"X-DNS-Prefetch-Control">> => <<"off">>,
            <<"X-Download-Options">> => <<"noopen">>,
            <<"X-Frame-Options">> => <<"SAMEORIGIN">>,
            <<"X-XSS-Protection">> => <<"1; mode=block">>
        },
        Req
    ),
    {ok, NewReq, Env}.
