#!/bin/sh
CRON_DIR=$(cd $(dirname "$0"); pwd)
echo $CRON_DIR
cmd="/bin/sh $CRON_DIR/cron_watchdog.sh& > /dev/null"
proc=`/bin/ps xaww | grep -v " grep" | grep -- "cron_watchdog.sh"`
if test -z "$proc"
then
	eval "$cmd"
fi


