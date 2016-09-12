<?php
define('ROOT_PATH', dirname(__FILE__));
include (ROOT_PATH . '/function.php');

// 定义常量
define("PRIVDATA_DIR", '/www/privdata/cron_demo');
define('CRON_STATUS_DIR', PRIVDATA_DIR . '/cron_status');
define('CONFIG_DIR', PRIVDATA_DIR . '/config');
define('LOG_DIR', PRIVDATA_DIR . '/log');
define('CRON_SWITCH_FILE', CONFIG_DIR . '/cron_switch.ini');

define("KEY_PREFIX", 'cron_demo:');

// 定义任务常量
define('TEST_CRON_KEY', KEY_PREFIX.'test');


