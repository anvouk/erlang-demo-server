-module(myappRebar_handler_home).

-export([
    init/2,
    content_types_accepted/2,
    content_types_provided/2,
    allowed_methods/2,
    show_home/2
]).

init(Req, Opts) ->
    {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
    {[<<"GET">>], Req, State}.

content_types_accepted(Req, State) ->
    {[{<<"text/html">>, show_home}], Req, State}.

content_types_provided(Req, State) ->
    {[{<<"text/html">>, show_home}], Req, State}.

show_home(Req, State) ->
    {ok, Body} = html_templates:render(home, []),
    Res = cowboy_req:reply(200, #{}, Body, Req),
    {stop, Res, State}.
