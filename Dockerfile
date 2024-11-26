FROM node:14-alpine

WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./

ENV DOCKERIZE_VERSION v0.8.0

RUN apk update --no-cache \
    && apk add --no-cache wget openssl \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apk del wget
    
RUN npm cache clean --force
RUN npm install

COPY ./ ./
COPY init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod a+r /docker-entrypoint-initdb.d/*

#RUN npm run build 

EXPOSE 8080

ENTRYPOINT ["npm","start"]