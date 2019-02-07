FROM node:8-alpine
LABEL maintainer="VCP Land Schleswig-Holstein e.V."

RUN apk update && \
    apk add bash curl git openssh supervisor --no-cache && \
    mkdir -p /var/wiki && \
    mkdir -p /logs

WORKDIR /var/wiki

COPY tools/build/supervisord.conf /etc/supervisord.conf
COPY assets ./assets
COPY server ./server
COPY tools ./tools
COPY config.sample.yml .
COPY package.json .
COPY LICENSE .
RUN npm install
RUN npm run build

EXPOSE 3000

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
