FROM crossbario/crossbar:pypy-slim-amd64-23.1.2

RUN apt-get update && \ 
    apt-get install -y --no-install-recommends gettext-base

ADD requirements.txt ./
RUN pip install --no-cache-dir -r ./requirements.txt
 
ENV WAMP_PORT=3100
ENV WAMP_AUTHID=backend
ENV WAMP_REALM=default
ENV PROMETHEUS_EXPORTER_PORT=9123

COPY exporter.py ./
COPY docker-entrypoint.sh ./
RUN chmod 777 ./docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]