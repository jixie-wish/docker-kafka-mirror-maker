FROM nimmis/java-centos:oracle-8-jre

# consumer configuration
ENV SOURCE_CLUSTER ""
ENV SOURCE_GROUPID ""
ENV SOURCE_KAFKA_SSL_TRUSTSTORE_LOCATION ""
ENV SOURCE_KAFKA_SSL_TRUSTSTORE_TYPE ""
ENV SOURCE_KAFKA_SSL_KEYSTORE_LOCATION ""
ENV SOURCE_KAFKA_SSL_KEYSTORE_TYPE ""
ENV SOURCE_KAFKA_SSL_KEYSTORE_PASSWORD ""

# producer configuration
ENV TARGET_CLUSTER ""
ENV SSL_CA_LOCATION "/etc/ssl/certs/"
ENV TARGET_KAFKA_USERNAME ""
ENV TARGET_KAFKA_PASSWORD ""

# mirror maker configuration
ENV WHITELIST *


RUN apt-get update
RUN apt-get install -y confluent-kafka-2.11
RUN apt-get install -y gettext
RUN apt-get install wget

RUN mkdir -p /etc/kafka-mirrormaker/
ADD ./consumer.config /tmp/kafka-mirrormaker/
ADD ./producer.config /tmp/kafka-mirrormaker/
ADD ./run.sh /etc/kafka-mirrormaker/
RUN chmod +x /etc/kafka-mirrormaker/run.sh

RUN mkdir -p /etc/kafka
RUN cd /etc;wget https://archive.apache.org/dist/kafka/2.6.3/kafka_2.13-2.6.3.tgz; tar -xvf kafka_2.13-2.6.3.tgz;mv kafka_2.13-2.6.3 kafka;rm kafka_2.13-2.6.3.tgz
ADD ./lib/*.jar /etc/kafka/libs
