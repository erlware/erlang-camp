#!/bin/sh
cd `dirname $0`

NAME=$1
shift

exec erl -pa $PWD/ebin -pa $PWD/deps/*/ebin -sname $NAME -setcookie rd -s resource_discovery start -config ebin/sys $@
