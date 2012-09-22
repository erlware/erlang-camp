-module(twit_server).

-behaviour(gen_server).

%% API
-export([start_link/0, twit/2, follow/2, follow/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-record(state, {subscriptions}).

%%%===================================================================
%%% API
%%%===================================================================

%% @doc
%% Starts the server
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% @doc
%% Send a message
-spec twit(Name :: string(), Msg :: string()) -> ok.
twit(Name, Msg) ->
    gen_server:call(?SERVER, {twit, {Name, Msg}}).


%% @doc
%% follow someone
-spec follow(Name, Node) -> ok when
      Node :: node(),
      Name :: string().
follow(Name, Node) ->
    gen_server:cast({?SERVER, Node}, {follow, {Name, self()}}).

follow(Name) ->
    follow(Name, node()).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
init([]) ->
    {ok, #state{subscriptions = dict:new()}}.

%% @doc
%% Handling call messages
%%
%% @spec handle_call(Request, From, State) ->
%%                                   {reply, Reply, State} |
%%                                   {reply, Reply, State, Timeout} |
%%                                   {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, Reply, State} |
%%                                   {stop, Reason, State}
handle_call({twit, {Name, Msg}}, _From, State) ->
    #state{subscriptions = Subscriptions} = State,
    send_to_subscribers(Name, Msg, Subscriptions),
    {reply, ok, State}.

%% @doc
%% Handling cast messages
%%
%% @spec handle_cast(Msg, State) -> {noreply, State} |
%%                                  {noreply, State, Timeout} |
%%                                  {stop, Reason, State}
handle_cast({follow, {Name, Pid}}, State) ->
    #state{subscriptions = Subscriptions} = State,
    NewSubscriptions = insert_subscription(Name, Pid, Subscriptions),
    {noreply, State#state{subscriptions = NewSubscriptions}}.

%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
handle_info(_Info, State) ->
    {noreply, State}.

%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
terminate(_Reason, _State) ->
    ok.

%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
insert_subscription(Name, Pid, Subscriptions) ->
    SubscriptionList = get_subscription_list(Name, Subscriptions),
    dict:store(Name, [Pid|SubscriptionList], Subscriptions).

send_to_subscribers(Name, Msg, Subscriptions) ->
    lists:foreach(
      fun(Pid) ->
	      % This is bad, raw messaging. Should have a client for this
	      % but it would complicate the example
	      Pid ! {twit, {Name, Msg}}
      end,
      get_subscription_list(Name, Subscriptions)).
			  
get_subscription_list(Name, Subscriptions) ->
    case dict:find(Name, Subscriptions) of
	{ok, SubscriptionList} -> 
	    SubscriptionList;
	error -> 	
	    []
    end.
    
