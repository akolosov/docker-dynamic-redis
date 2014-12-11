#!/bin/sh

mkdir -p /etc/redis
mkdir -p /usr/local/lib/redis

cd /tmp

git clone https://github.com/lloyd/yajl
cd yajl
./configure; make
cd ..

git clone https://github.com/mattsta/redis
cd redis
git checkout dynamic-redis-2.8
make
make install
cp -f src/redis-sentinel /usr/local/bin
cd ..

git clone https://github.com/mattsta/krmt
cd krmt
make clean; make -j
cp -f *.so /usr/local/lib/redis/
cd /  

rm -rf /tmp/*
