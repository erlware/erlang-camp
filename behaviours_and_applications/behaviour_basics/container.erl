-module(container).

-export([start/1, start/2, send/2]).
-export([init/3]).

start(CallBack) ->
    start(CallBack, undefined).

start(CallBack, Name) ->
    proc_lib:start_link(?MODULE, init, [self(), CallBack, Name]).

send(Pid, Msg) ->
    Pid ! {'$container', send, Msg}.

%%% Internal functions

init(Parent, CallBack, Name) ->
    try
        {ok, State} = CallBack:init(),
        register_name(Name),
        proc_lib:init_ack(Parent, {ok, self()}),
        loop(CallBack, State)
    catch
        _C:E ->
            io:format("going down with ~p~n", [E]),
            exit(E)
    end.

register_name(undefined) ->
    ok;
register_name(Name) ->
    register(Name, self()).

loop(CallBack, State) ->
    receive
        {'$container', send, Msg} ->
            case catch CallBack:handle_msg(Msg, State) of
                {ok, NewState} ->
                    loop(CallBack, NewState);
                {stop, NewState} ->
                    io:format("stopping process ~p with state ~p~n", [self(), NewState]),
                    ok;
                Error ->
                    io:format("application error ~p~n", [Error]),
                    exit(Error)
            end;
        BadMsg ->
            io:format("bad message ~p~n", [BadMsg]),
            exit(BadMsg)
    end.
