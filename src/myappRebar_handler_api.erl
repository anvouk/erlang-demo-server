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

retrieve_json_data(Uri) ->
    case httpc:request(get, {Uri, []}, [], []) of
        {ok, {{_, 200, _}, _Headers, Body}} ->
            lager:debug("received data: ~s", [Body]),
            % TODO: is this conversion ok? cannot find alternatives...
            {ok, jsone:decode(erlang:list_to_binary(Body))};
        {error, Reason} ->
            {error, Reason}
    end.

handle(Req = #{method := <<"GET">>}, State) ->
    {ok, RetrievedData} = retrieve_json_data("https://jsonplaceholder.typicode.com/todos/1"),
    ResBody = jsone:encode(#{
        <<"method">> => cowboy_req:method(Req),
        <<"data">> => RetrievedData
    }),
    Res = cowboy_req:reply(200, #{}, ResBody, Req),
    {stop, Res, State};
handle(Req = #{method := <<"POST">>}, State) ->
    Body = jsone:encode(#{
        <<"method">> => cowboy_req:method(Req)
    }),
    Res = cowboy_req:reply(200, #{}, Body, Req),
    {stop, Res, State}.
