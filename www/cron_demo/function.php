<?php
function cron_switch($task = 'all') {
	$cron_switch = parse_ini_file(CRON_SWITCH_FILE);

	if ($task == 'all') {
		return $cron_switch;
	} else {
		$task = str_replace(KEY_PREFIX, '', $task);
		$current_cron_switch = $cron_switch [$task];
		if($GLOBALS['current_cron_switch'] && $GLOBALS['current_cron_switch']<$current_cron_switch){
			//若小于当前配置文件
			$current_cron_switch = 0;
		}
		if($current_cron_switch){
			$GLOBALS['current_cron_switch'] = $current_cron_switch;
		}
		return $current_cron_switch;
	}

}
