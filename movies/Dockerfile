FROM nginx:1.15-alpine

# Customize Bash
ENV PS1 "\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

ENV STORAGE_PATH /var/storage

# Install base package
RUN apk add --no-cache tzdata bash vim htop supervisor \
  python3 py-pip python3-dev build-base postgresql-dev \
  && pip3 install --upgrade pip \
  && pip2 install --upgrade pip \
  && pip2 install supervisor-stdout

# Setting timezone and delete unnecessary time zones
RUN cp /usr/share/zoneinfo/America/Bogota /etc/localtime && apk del tzdata

# Copy config files
COPY etc /etc
RUN rm -f /etc/nginx/conf.d/default.conf

# docker-entrypoint
COPY docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh

# Supervisor
RUN mkdir -p /var/log/supervisor

# Install requirements.txt file
COPY backend/requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt --no-deps

# Copia el codigo
COPY backend /var/www/backend

WORKDIR /var/www/backend

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["supervisord"]