#
# Dockerfile for nifi
#

FROM java:8-jre-alpine
MAINTAINER s3ni0r <elmehdi.elbrini@verteego.com>

ENV NIFI_VERSION 1.1.0
ENV NIFI_FILE nifi-${NIFI_VERSION}-bin.tar.gz
ENV NIFI_URL https://storage.googleapis.com/verteego-vds/nifi/nifi-assembly/target/nifi-1.1.0-SNAPSHOT-bin.tar.gz
ENV NIFI_HOME /opt/nifi
ENV NIFI_PORT 33331
ENV NIFI_LOG_DIR /var/log/nifi
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.1

WORKDIR $NIFI_HOME


RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

RUN set -xe \
    && apk add --no-cache bash curl tar python python-dev py-pip \
    && curl -sSL ${NIFI_URL} | tar xz --strip-components=1 \
    && apk del curl tar \
    && addgroup -g 1000 nifi \
    && adduser -h ${NIFI_HOME} -s /bin/bash -G nifi -u 1000 -D -H nifi \
    && mkdir -p content_repository database_repository flowfile_repository provenance_repository ${NIFI_LOG_DIR}\
    && chown -R nifi:nifi ${NIFI_HOME} \
    && chown -R nifi:nifi ${NIFI_LOG_DIR}

RUN pip install j2cli[yaml]

COPY templates/bootstrap.conf.j2 /tmp/bootstrap.conf.j2
COPY templates/nifi.properties.j2 /tmp/nifi.properties.j2
COPY templates/nifi-env.sh.j2 /tmp/nifi-env.sh.j2
COPY templates/supervisord.conf /etc/supervisord.conf
COPY config/vars_file.yml /tmp/vars_file.yml

RUN j2 /tmp/bootstrap.conf.j2 /tmp/vars_file.yml > ${NIFI_HOME}/conf/bootstrap.conf
RUN j2 /tmp/nifi.properties.j2 /tmp/vars_file.yml > ${NIFI_HOME}/conf/nifi.properties
RUN j2 /tmp/nifi-env.sh.j2 /tmp/vars_file.yml > ${NIFI_HOME}/conf/nifi-env.sh

VOLUME ${NIFI_HOME}/content_repository  \
       ${NIFI_HOME}/database_repository \
       ${NIFI_HOME}/flowfile_repository \
       ${NIFI_HOME}/provenance_repository

EXPOSE ${NIFI_PORT}

#USER nifi

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]