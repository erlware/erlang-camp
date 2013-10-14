Essentials Part 1 Cheatsheet
===========

## Modules and Functions 

The file name for the following module must match the 
module name and so must be "foo.erl"

```
%%% @author Billy Erlware
%%% @doc contains add func
%%% @copyright 2013 Erlware

-module(foo).
-export([func/2]).

%% @doc this function of arity 2 has 2 clauses.
-spec func(atom() | integer(), integer()) -> atom() | integer().
func(undefined, _Var2) ->
    undefined;
func(Var1, Var2) ->
	Var3 = Var1 + Var2,
	Var3.
```

## Pattern Matching 

```
a = a.   % This matched two atoms successfully
a = "a". % This throws an exception as the string "a" is not the atom a
A = a.   % The variable A is now bound to a
A = a.   % This matched a with a
A = b.   % throws a badmatch exception as a is not b

1> foo:func(tag_b, 1).
```

Pattern matching works in functions. The shell call above matches The
second function clause below in the module foo.

```
matchit(tag_a, Var) ->
    ...;
matchit(tag_b, Var) ->
```

## Guards

A function clause can be guarded in the following way

```
func(Var1, Var2) when Var1 /= undefined ->
```

## Recursion

Accumulate in a tail recursive function
```
accumulate_it(0, Acc) ->
	Acc;
accumulate_it(N, Acc) ->
	accumulate_it(N - 1, Acc + N).
```

## Lists
```
1> [1|[2, 3, 4]].
[1, 2, 3, 4]

2> [H|T] = [1, 2, 3, 4].
3> H.
1
4> T.
[2, 3, 4] 
```

## Higher order Functions

A an anonymous function that multiplies its argument by 2

```
fun(N) -> X * 2 end.
```


