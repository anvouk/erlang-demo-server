-module(myappRebar_handler_ui).

-export([
    init/2,
    content_types_accepted/2,
    content_types_provided/2,
    allowed_methods/2,
    show_login/2,
    handle_login/2
]).

init(Req, Opts) ->
    {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
    {[<<"GET">>, <<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
    {
        [
            {<<"text/html">>, show_login},
            {<<"application/x-www-form-urlencoded">>, handle_login}
        ],
        Req,
        State
    }.

content_types_provided(Req, State) ->
    {[{<<"text/html">>, show_login}], Req, State}.

show_login(Req = #{method := <<"GET">>}, State) ->
    {ok, Body} = html_templates:render(login, []),
    Res = cowboy_req:reply(200, #{}, Body, Req),
    {stop, Res, State};
show_login(Req, State) ->
    Res = cowboy_req:reply(405, #{}, "", Req),
    {stop, Res, State}.

handle_login(Req = #{method := <<"POST">>}, State) ->
    {ok, ReceivedBody, Req1} = cowboy_req:read_urlencoded_body(Req),
    lager:info("received form data: ~p", [ReceivedBody]),
    Res = cowboy_req:reply(301, #{<<"Location">> => <<"/">>}, "", Req1),
    {stop, Res, State};
handle_login(Req, State) ->
    Res = cowboy_req:reply(405, #{}, "", Req),
    {stop, Res, State}.
