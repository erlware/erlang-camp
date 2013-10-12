Hey Erlangers!

Youw will find complete versions of code for simple cache, as well as the entity manager in here. Details on each are below.

If you find any errors or have any suggestions, please e-mail us at organizers@erlangcamp.com

Thanks!

******************
** simple_cache **
******************

This version of simple_cache includes the supervisor, application, and also has lager (logging) added to it. You will remember the lager dependency was added by first adding a rebar.config

Here are the steps on the command line to get the code up and running.

(assuming you are in the events_and_logs directory)

$ cd simple_cache
$ ./rebar get-deps
$ ./rebar compile
$ erl -pa ebin -env ERL_LIBS deps
> application:start(lager).
> application:start(simple_cache).
> appmon:start().
> sc_server:insert(jordan, wilberding).
ok
> sc_server:lookup(jordan).
wilberding
> sc_server:stop().
07:23:08.015 [error] gen_server sc_server terminated with reason: just_cuz
07:23:08.016 [error] CRASH REPORT Process sc_server with 0 neighbours exited with reason: just_cuz in gen_server:terminate/6 line 744
07:23:08.016 [info] Hey, this is starting!!
**(the above message was generated from our call to lager:info in the start_link of sc_server!)**
07:23:08.016 [error] Supervisor sc_sup had child sc_server started with sc_server:start_link() at <0.57.0> exit with reason just_cuz in context child_terminated
> sc_server:insert(jordan, wilberding).
ok
> sc_server:lookup(jordan).
wilberding

Feel free to add your own logging calls to lager elsewhere and whatever else you want, have some fun! Also, take a look at the logs directory creating by lager to see what interesting things go there.



********************
** entity_manager **
********************

This is a simple example of utilizing the gen_event framework to create an Entity Manager.

I have created a code to drive the entity manager in em_demo.erl, but you can take those commands and type them yourself directly into the shell if you wanted to.

To run the code, doing the following.

(assuming you are in the events_and_logs directory)

$ cd entity_manager
$ erlc *.erl
$ erl
> em_demo:go().

Again, please freel free to play around!
