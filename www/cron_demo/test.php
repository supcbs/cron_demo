<?php
define('ROOT_PATH', dirname(__FILE__));

include(ROOT_PATH . '/cron_init.php');
$log_file = LOG_DIR . '/test_cron.log';
$pid_status_log = CRON_STATUS_DIR . '/' . getmypid();
$i = 0;
while (true) {
	file_put_contents($pid_status_log, 1);

	$cron_flag = cron_switch(TEST_CRON_KEY);
	
	if (!$cron_flag) {
		unlink($pid_status_log);
		exit();
	}

	// 可从队列中取出数据进行处理
	// 这里作为例子，以记录一个日志好了
	$msg = $i ."\n";
	file_put_contents($log_file, $msg, FILE_APPEND);
	
	sleep(10);
	$i++;
}

