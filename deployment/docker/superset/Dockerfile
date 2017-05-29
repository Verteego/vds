FROM python:2.7

# Install
ENV SUPERSET_VERSION 0.17.1

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    libsasl2-dev \
    libldap2-dev \
    supervisor \
    && apt-get clean -y
RUN apt-get install -y expect
RUN apt-get install -y vim
RUN pip --no-cache-dir install https://storage.googleapis.com/verteego-vds/superset/dist/superset-0.15.0.tar.gz \
    mysqlclient \
    sqlalchemy-redshift \
    redis \
    celery \
    "celery[redis]" \
    Werkzeug \
    jinja2-cli

# Default config
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=$PATH:/home/superset/.bin \
    PYTHONPATH=/home/superset/superset_config.py:$PYTHONPATH

# Run as superset user
WORKDIR /home/superset

RUN pip install jinja2-cli[yaml]

RUN groupadd -r superset && \
    useradd -r -m -g superset superset && \
    mkdir -p /home/superset/db /var/log/supervisor /var/run/supervisor && \
    chown -R superset:superset /home/superset && \
    chown -R superset:superset /var/log/supervisor && \
    chown -R superset:superset /var/run/supervisor

RUN pip install jinja2-cli[yaml]
COPY config/vars_file.yml /tmp/vars_file.yml
COPY templates/superset/superset_config.py /tmp/superset_config.py.j2
COPY templates/create-user.sh /tmp/create-user.sh.j2
RUN jinja2  /tmp/superset_config.py.j2 /tmp/vars_file.yml --format=yml > /home/superset/superset_config.py
RUN jinja2  /tmp/create-user.sh.j2 /tmp/vars_file.yml --format=yml > /tmp/create-user.sh

USER superset
RUN expect /tmp/create-user.sh
RUN superset db upgrade

# Deploy
EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
ENTRYPOINT ["superset"]
CMD ["runserver"]
#USER superset