#
# Regular cron jobs for the 7digital-mono package
#
0 4	* * *	root	[ -x /usr/bin/7digital-mono_maintenance ] && /usr/bin/7digital-mono_maintenance
