#!/bin/bash

NAME="django_app"
DJANGODIR=/var/codebase/backend/app
SOCKFILE=/tmp/gunicorn.sock
USER=nobody
GROUP=nogroup
NUM_WORKERS=4
DJANGO_SETTINGS_MODULE=proassetz.settings.prod
DJANGO_WSGI_MODULE=proassetz.wsgi
PID_FILE=/tmp/gunicorn.pid
echo "Starting $NAME as `whoami`"

cd $DJANGODIR
source /home/ubuntu/django_env/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

exec gunicorn -p $PID_FILE ${DJANGO_WSGI_MODULE}:application \
 --name $NAME \
 --workers $NUM_WORKERS \
 --user=$USER --group=$GROUP \
 --bind=unix:$SOCKFILE \
 --log-level=debug \
 --log-file=-
