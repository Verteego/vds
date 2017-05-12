FROM java:8
MAINTAINER s3ni0r <elmehdi.elbrini@verteego.com>

ENV OPENREFINE_HOME /opt/openrefine
ENV OPENREFINE_PORT 33332
ENV OPENREFINE_HOST 0.0.0.0

#RUN echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
#RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections
#
#RUN apt-get -y -q update; \
#    apt-get -y -q install wget software-properties-common supervisor
#
#RUN add-apt-repository 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main'; \
#    apt-get -y -q update
#
#RUN apt-get install -y --force-yes -q oracle-java7-installer

RUN useradd -ms /bin/bash openrefine
RUN mkdir -p ${OPENREFINE_HOME} && \
chmod 755 ${OPENREFINE_HOME} && \
chown openrefine ${OPENREFINE_HOME} && \
chgrp openrefine ${OPENREFINE_HOME}

# download and "mount" OpenRefine
WORKDIR ${OPENREFINE_HOME}
RUN wget -O - --no-check-certificate https://storage.googleapis.com/verteego-vds/openrefine/dist/openrefine-linux-1.0.tar.gz | tar -xz --strip=1
#COPY templates/supervisord.conf /etc/supervisord.conf
COPY ./start.sh ${OPENREFINE_HOME}/start.sh
RUN chmod +x ${OPENREFINE_HOME}/start.sh
RUN sed -i s/PORT/${OPENREFINE_PORT}/ ${OPENREFINE_HOME}/start.sh
RUN sed -i s/HOST/${OPENREFINE_HOST}/ ${OPENREFINE_HOME}/start.sh

EXPOSE ${OPENREFINE_PORT}

CMD ["start.sh"]