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
  envsubst < /etc/nginx/conf.d/frontend.template > /etc/nginx/conf.d/frontend.conf
  rm -f /etc/nginx/conf.d/*.template

  # Django
  python3 manage.py migrate
  python3 manage.py collectstatic --noinput
  mkdir -p fixtures
  time python3 manage.py importmovies --file=data/movie_metadata.tar.xz
  files=$(ls fixtures)
  time python3 manage.py loaddata $files

  supervisord -c /etc/supervisord.conf


else
  exec "$@"
fi
                                                                                                                            1,1          Tod