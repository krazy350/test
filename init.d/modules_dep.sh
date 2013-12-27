#! /bin/sh
### BEGIN INIT INFO
# Provides:          modules_dep
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 6
# Short-Description: modules.dep creation.
# Description:       Create and destroy modules.dep.
### END INIT INFO

case "" in
  start|"")
	if [ ! -d "/lib/modules/2.6.18-028stab067.4" ]; then
		mkdir /lib/modules/2.6.18-028stab067.4
	fi
	depmod -a >/dev/null 2>&1
	;;
  restart|reload|force-reload)
	echo "Error: argument '' not supported" >&2
	exit 3
	;;
  stop)
	if [ -d "/lib/modules/2.6.18-028stab067.4" ]; then
		rm -rf /lib/modules/2.6.18-028stab067.4
	fi
	;;
  *)
	echo "Usage: modules_dep.sh [start|stop]" >&2
	exit 3
	;;
esac

:


