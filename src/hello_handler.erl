-module(hello_handler).

-export([init/2]).

-export([content_types_accepted/2]).
-export([content_types_provided/2]).
-export([allowed_methods/2]).
-export([hello_to_json/2]).

init(Req, Opts) ->
    {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
    {[<<"GET">>], Req, State}.

content_types_accepted(Req, State) ->
    {[{<<"application/json">>, hello_to_json}], Req, State}.

content_types_provided(Req, State) ->
    {[{<<"application/json">>, hello_to_json}], Req, State}.

hello_to_json(Req, State) ->
    Body = jsone:encode(#{
        <<"library">> => <<"jsone">>,
        <<"awesome">> => true
    }),
    {Body, Req, State}.
