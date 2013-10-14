OTP Cheatsheet 
===========


## start_link flow
spawn and link a gen server
``gen_server:start_link({local, Name}, ImplModule, InitArgs, Options).``

The callback for start_link/4 is init.
```
init(InitArgs) ->
	{ok, InitialState}.
```

## gen_server:cast flow 
Cast is the gen_server function used for async messaging.

gen_server:cast(Server, Msg).

for example

gen_server:cast(?SERVER, {lookup, Key}).

The callback for cast is handle_cast/2.

handle_cast(Msg, State) ->
	{noreply, NewState}.

## call flow
Call is the gen server function that is used for syncronous messaging.

gen_server:call(Server, Msg).

The callback function for call is handle_call/3.
handle_call(Msg, From, State) ->
	{reply, Reply, NewState}.

## Stopping a gen_server
if you want to stop the server from either handle call or cast simply
return the tuple

{stop, Reason, State}

## the .app file.
Rebar will generate a .app.src file in your source directory. This is what 
you should modify when creating an app. When you compile your code rebar 
will turn the .app.src file into a .app file and place it in the 
ebin directory. 

```
{application, simple_cache, % App name
 [
  {description, ”kv store"}, 
  {vsn, "1"},
  {registered, []},
  {applications, [ 
                  kernel,
                  stdlib
                 ]},
  {mod, {sc_app, []}}, % 'mod' is the important tuple. This is what is called
					   % to start your app. In this case sc_app:start/2 
					   % with no args
  {env, []}
 ]}.
```

## Misc
To pull key value pairs out of a kv list [{a, b}, {c, d}] use 
proplists:get_value/2

