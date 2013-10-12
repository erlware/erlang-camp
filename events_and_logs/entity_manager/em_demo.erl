-module(em_demo).
-export([go/0]).

%% Entity Manager demonstration

go() ->
    %% Create Entity, add health component, then kill it!
    {ok, Entity} = em:start_link(),
    em:add_component(Entity, health_component, 100),
    em:notify(Entity, {hit, 50}),
    em:notify(Entity, {hit, 20}),
    em:notify(Entity, {hit, 30}),
    em:notify(Entity, {hit, 30}),

    %% Our Entity is technically dead.. but let's give it a coordinate
    %% component, and some weapons!
    em:add_component(Entity, xy_component, {50, 50}),
    em:notify(Entity, {change, {y, 35}}),
    em:add_component(Entity, weapon_component, ["chair"]),
    em:notify(Entity, {add_weapon, "bat"}),
    em:notify(Entity, {add_weapon, "chainsaw"}),
    em:notify(Entity, {list_weapons}),
    em:notify(Entity, {remove_weapon, "chainsaw"}),
    em:notify(Entity, list_weapons),

    %% Let's make a new entity and have it find a surprise..
    %% (shows two separate components reacting to same event
    {ok, Entity2} = em:start_link(),
    em:add_component(Entity2, xy_component, {50, 50}),
    em:add_component(Entity2, weapon_component, ["chair"]),
    em:notify(Entity2, {change, {{x, y}, {489, 937}}}),
    em:notify(Entity2, list_weapons).
