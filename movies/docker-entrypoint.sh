#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then
  # Directorios
  mkdir -p ${STORAGE_PATH}/logs
  mkdir -p ${STORAGE_PATH}/media
  mkdir -p ${STORAGE_PATH}/static

  export DOLLAR='$'

  # Supervisor
  envsubst < /etc/supervisor.d/00-backend.template > /etc/supervisor.d/00-backend.conf
  rm -f /etc/supervisor.d/*.template

  # Nginx
  envsubst < /etc/nginx/conf.d/backend.template > /etc/nginx/conf.d/backend.conf
  rm -f /etc/nginx/conf.d/*.template

  # Django
  python3 manage.py migrate
  python3 manage.py collectstatic --noinput

  supervisord -c /etc/supervisord.conf
else
  exec "$@"
fi
                                                                                                                            1,1          Tod