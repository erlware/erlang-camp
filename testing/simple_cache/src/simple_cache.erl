-module(simple_cache).

-behaviour(gen_server).

%% API
-export([start_link/0, insert/2, lookup/1, delete/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {store}).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

insert(Key, Value) ->
    gen_server:cast(?SERVER, {insert, Key, Value}).

lookup(Key) ->
    gen_server:call(?SERVER, {lookup, Key}).

delete(Key) ->
    gen_server:cast(?SERVER, {delete, Key}).


%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
init([]) ->
    {ok, #state{store=sc_store:init()}}.

%% @private
handle_call({lookup, Key}, _From, State = #state{store=Store}) ->
    sc_event:lookup(Key),
    Reply = try
                {ok, Pid} = sc_store:lookup(Store, Key),
                {ok, Value} = sc_element:fetch(Pid),
                {ok, Value}
            catch
                _Class:_Exception ->
                    {error, not_found}
            end,
    {reply, Reply, State}.

%% @private
handle_cast({insert, Key, Value}, State = #state{store=Store0}) ->
    Store1 = case sc_store:lookup(Store0, Key) of
                 {ok, Pid} ->
                     sc_event:replace(Key, Value),
                     sc_element:replace(Pid, Value),
                     Store0;
                 error ->
                     {ok, Pid} = sc_element:create(Value),
                     sc_event:create(Key, Value),
                     sc_store:insert(Store0, Key, Pid)
    end,
    {noreply, State#state{store=Store1}};
handle_cast({delete, Key}, State = #state{store=Store}) ->
    sc_event:delete(Key),
    case sc_store:lookup(Store, Key) of
        {ok, Pid} ->
            sc_element:delete(Pid);
        error ->
            ok
    end,
    {noreply, State#state{store=sc_store:delete(Store, Key)}}.

%% @private
handle_info(_Info, State) ->
    {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
