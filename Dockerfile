FROM dockerfile/ubuntu

# Install dependencies
RUN apt-get update
RUN apt-get upgrade -yqq
RUN apt-get -yqq install make gcc tar git
RUN apt-get -yqq clean
RUN rm -rf /var/lib/apt/lists/*

ADD make-install.sh /tmp/make-install.sh

# Install Redis
RUN /bin/bash /tmp/make-install.sh

ADD sentinel.conf /etc/redis/sentinel.conf
ADD redis.conf /etc/redis/redis.conf
ADD redis-startup.sh /usr/local/bin/redis-startup.sh

RUN chmod 755 /usr/local/bin/redis-startup.sh

# Define mountable directories
VOLUME ["/data/logs", "/data/db", "/data/conf"]

# Define working directory
WORKDIR /data

RUN mkdir -p /data/db
RUN mkdir -p /data/logs
RUN mkdir -p /data/conf

# Define entrypoint
ENTRYPOINT ["/bin/bash", "/usr/local/bin/redis-startup.sh"]

# Expose ports
EXPOSE 26379 6379