#!/bin/bash
#该脚本需在bash版本>=4中执行
CRON_DIR=$(cd $(dirname "$0"); pwd)
zombie_alert_cmd="/bin/sh $CRON_DIR/cron_zombie_alert.sh& > /dev/null"
CRON_COUNT_INI=/www/privdata/cron_demo/config/cron_count.ini
echo $CRON_COUNT_INI
declare -A deamon_map

#key 为cron_count里的key value为命令脚本地址
deamon_map["test"]="$CRON_DIR/test.php"

while true; do
	#//循环执行deamon_map里的命令
	for deamon_count_key in "${!deamon_map[@]}" ; do
		echo $deamon_count_key
		SUM=`grep "^$deamon_count_key *=" "$CRON_COUNT_INI" | awk '{print $3}'`
		if ! (echo $SUM | egrep -q '^[0-9]+$'); then
			SUM=1   #若在cron_count.ini中不存在，则默认赋值队列并发数1
		fi
		php_script="${deamon_map["$deamon_count_key"]}"
		proc=`/bin/ps xaww | grep -v " grep" | grep "$php_script" |wc -l`
		current_count=$proc
		if [ $current_count -lt "$SUM" ];then
			need_to_open_count=`expr $SUM - $current_count`
			while [ $need_to_open_count -gt 0 ]
			do
				php "$php_script" &
				(( need_to_open_count-- ))
			done
		fi
	done

	#//zombie_alert
	eval "$zombie_alert_cmd"
	sleep 1
done



