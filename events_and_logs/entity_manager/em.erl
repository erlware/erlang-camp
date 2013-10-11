-module (em).
-export ([start_link/0,
          add_component/3,
          remove_component/2,
          components/1,
          notify/2,
          destroy/1]).

start_link() ->
    gen_event:start_link().

add_component(Pid, Component, Args) ->
    gen_event:add_handler(Pid, Component, Args).

remove_component(Pid, Component) ->
    gen_event:delete_handler(Pid, Component).

components(Pid) ->
    gen_event:which_handlers(Pid).

notify(Pid, Event) ->
    gen_event:notify(Pid, Event).

destroy(Pid) ->
    gen_event:stop(Pid).
