-module(myappRebar_handler_api).

-export([
    init/2,
    content_types_accepted/2,
    content_types_provided/2,
    allowed_methods/2,
    handle/2
]).

init(Req, Opts) ->
    {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
    {[<<"GET">>, <<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
    {[{<<"application/json">>, handle}], Req, State}.

content_types_provided(Req, State) ->
    {[{<<"application/json">>, handle}], Req, State}.

handle(Req0 = #{method := <<"GET">>}, State) ->
    Body = jsone:encode(#{
        <<"method">> => cowboy_req:method(Req0)
    }),
    Req = cowboy_req:reply(200, #{}, Body, Req0),
    {stop, Req, State};
handle(Req0 = #{method := <<"POST">>}, State) ->
    Body = jsone:encode(#{
        <<"method">> => cowboy_req:method(Req0)
    }),
    Req = cowboy_req:reply(200, #{}, Body, Req0),
    {stop, Req, State}.
