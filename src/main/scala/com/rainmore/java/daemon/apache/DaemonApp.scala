package com.rainmore.java.daemon.apache

import org.apache.commons.daemon.{DaemonContext, Daemon}
import java.util.{Timer, Date, TimerTask}
import org.slf4j.LoggerFactory

trait Logging {
    val logger = LoggerFactory.getLogger(getClass.getName)
}

class DemoTask extends TimerTask with Logging {
    def run(): Unit = {
        logger.info(new Date() + " --- running---")
    }
}

class DaemonApp extends Daemon with Logging {

    var timer: Timer = _

    def main(args: Array[String]) = {
        timer = new Timer
        timer.schedule(new DemoTask, 0, 1000)
    }

    def destroy(): Unit = logger.info("destroy ...")

    def stop(): Unit = {
        logger.info("stop ...")
        timer.cancel()
    }

    def start(): Unit = {
        logger.info("start ...")
        main(null)
    }

    def init(context: DaemonContext): Unit = logger.info("initialize...")
}
