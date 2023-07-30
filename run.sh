#!/bin/bash

set -e

envsubst < /tmp/mirror-maker/producer.config > /etc/mirror-maker/producer.config
envsubst < /tmp/mirror-maker/consumer.config > /etc/mirror-maker/consumer.config

/etc/kafka/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST} --abort.on.send.failure true --new.consumer --producer.config /etc/kafka-mirrormaker/producer.config --consumer.config /etc/kafka-mirrormaker/consumer.config
