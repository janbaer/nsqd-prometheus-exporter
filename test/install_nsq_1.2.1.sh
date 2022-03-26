#!/bin/bash
set -ex -o pipefail

NSQ_VERSION=1.2.1
GO_BUILD_VERSION=1.16.6

# Install NSQ ${NSQ_VERSION}
cd /tmp
curl -L https://github.com/nsqio/nsq/releases/download/v${NSQ_VERSION}/nsq-${NSQ_VERSION}.linux-amd64.go${GO_BUILD_VERSION}.tar.gz -o /tmp/nsq-${NSQ_VERSION}.linux-amd64.go${GO_BUILD_VERSION}.tar.gz
tar -zxvf /tmp/nsq-${NSQ_VERSION}.linux-amd64.go${GO_BUILD_VERSION}.tar.gz
sudo cp -R /tmp/nsq-${NSQ_VERSION}.linux-amd64.go${GO_BUILD_VERSION}/bin/. /usr/local/bin

# Start nsqlookupd & nsqd
nsqlookupd &
nsqd -lookupd-tcp-address localhost:4160 &

# Emit test message
sleep 1
echo 'test' | to_nsq -nsqd-tcp-address localhost:4150 -topic test -rate 2
