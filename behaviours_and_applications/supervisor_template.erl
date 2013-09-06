%%% @author You 
%%% @copyright (C) 2013, Erlware
%%% @doc

-module(supervisor_template).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).
-define(IMPLEMENTATION_MODULE, ?MODULE).

%%%======================================================================
%%% API
%%%======================================================================

%% @doc Starts the supervisor.
-spec start_link() -> {ok, pid()} | ignore | {error, term()}
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?IMPLEMENTATION_MODULE, []).


%%%======================================================================
%%% Behaviour Callback Functions
%%%======================================================================
-spec init(Args::list()) -> {ok, {SupFlags, [ChildSpec]}} |
                     ignore |
					 {error, Reason::term()}.
init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    Restart = permanent,
    Shutdown = 2000,
    Type = worker,

    AChild = {module_name, {module_name, start_link, []},
	      Restart, Shutdown, Type, [module_name]},

    {ok, {SupFlags, [AChild]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
