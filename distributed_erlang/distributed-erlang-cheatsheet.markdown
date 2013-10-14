Distributed Erlang Cheatsheet
=============

Get the process id of the current process
self()

Receive a message out of a mailbox and do something with it.
receive X -> X * 2 end

More complex Receive
receive 
	X when is_integer(X) -> 
		X * 2;
	X -> 
		{error, not_integer}
after
	1000 ->
		{error, timeout}
end.

Spawn a process that prints its own process id
spawn(fun() -> io:format("process id of spawned process ~p~n", [self]) end).

Register a process
register(Name::atom(), Pid).

Start a distributed node called a
erl -name a
erl -sname a

Ping and connect with a remote node called a@my-machine.
1> net_adm:ping('a@my-machine').


