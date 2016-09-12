#!/bin/sh
PID_LOG=/www/privdata/cron_demo/cron_status/
KILL_LOG=/www/privdata/cron_demo/log/cron_kill.log
Minute=30

#//PID_LOG
cd "$PID_LOG"
if [ "$?" == 0 ];then
	for pid in `find ./ -mmin +"$Minute"| grep -v /$ | awk -F '/' '{print $2}'`
	do
		if [ "$pid" != '' ];then
			NOW=`date +%Y-%m-%d_%H:%M`
			HOSTNAME=`hostname`
			nl='
			'
			PROCESS=`ps p$pid fuh`
			if [ "$PROCESS" != '' ];then
				PSTACK=`pstack $pid`
				TMP=`timeout 2 strace -p $pid -o tmp.out`
				STRACE=`cat tmp.out`
				rm tmp.out
			fi
			message="$NOW $HOSTNAME zombie process id $pid $nl$PROCESS$nl$PSTACK$nl$STRACE----------------------------------"
			echo "$message">>"$KILL_LOG"
			#kill "$pid"
			cd  "$PID_LOG"
			rm -r "$pid"
			#进行邮件或者其他的形式将message的内容同步出去
		fi
	done
fi

