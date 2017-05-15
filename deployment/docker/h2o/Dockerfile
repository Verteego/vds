FROM java:8-jre-alpine
MAINTAINER s3ni0r <elmehdi.elbrini@verteego.com>

ENV H2O_URL https://storage.googleapis.com/verteego-vds/h2o/build/h2o.tar.gz
ENV H2O_HOME /opt/h2o
ENV H2O_LOG_DIR /var/log/h2o
ENV H2O_PORT 33333
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.1

WORKDIR $H2O_HOME

RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

RUN set -xe \
    && apk add --no-cache bash curl tar \
    && curl -sSL ${H2O_URL} | tar xz \
    && apk del curl tar \
    && addgroup -g 1000 h2o \
    && adduser -h ${H2O_HOME} -s /bin/bash -G h2o -u 1000 -D -H h2o \
    && mkdir -p ${H2O_LOG_DIR} \
    && chown -R h2o:h2o ${H2O_LOG_DIR} \
    && chown -R h2o:h2o ${H2O_HOME}

COPY templates/supervisord.conf /etc/supervisord.conf

EXPOSE ${H2O_PORT}

#USER h2o

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]