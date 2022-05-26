#!/bin/sh
/woapps/wotaskd.woa/wotaskd &
/woapps/JavaMonitor.woa/JavaMonitor -DWOPort=56789 &
httpd-foreground
