#!/bin/bash
/usr/bin/killall celery
rm -f /home/ubuntu/env/run/celery.pid
source /home/ubuntu/env/bin/activate
export DJANGO_SETTINGS_MODULE=Mother.settings.stage
cd /var/codebase/mwallet/app/ && celery -A Mother --pidfile="/home/ubuntu/env/run/celery.pid" worker -l info -n proassetz-celery-worker
