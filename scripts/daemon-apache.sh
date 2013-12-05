#!/bin/sh

# Setup variables
EXEC=/usr/bin/jsvc
JAVA_HOME=/usr/lib/jvm/java-7-oracle
CLASS_PATH="/usr/share/java/commons-daemon.jar":"/home/jrong/Sites/Daemon01/build/distributions/Daemon01/lib/*"
CLASS=com.worldmanager.daemon.apache.DaemonApp
USER=jrong
PID=/tmp/example.pid
LOG_OUT=/tmp/example.out
LOG_ERR=/tmp/example.err
JAVA_OPTS="-Ddistribution.dir=/tmp"

do_exec()
{
    $EXEC -home "$JAVA_HOME" -cp $CLASS_PATH -user $USER -outfile $LOG_OUT -errfile $LOG_ERR -pidfile $PID $1 $CLASS
}

case "$1" in
    start)
        do_exec
            ;;
    stop)
        do_exec "-stop"
            ;;
    restart)
        if [ -f "$PID" ]; then
            do_exec "-stop"
            do_exec
        else
            echo "service not running, will do nothing"
            exit 1
        fi
            ;;
    *)
            echo "usage: daemon {start|stop|restart}" >&2
            exit 3
            ;;
esac
