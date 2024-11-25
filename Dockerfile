FROM node:14-alpine

WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./

RUN npm cache clean --force
RUN npm install

COPY ./ ./
COPY init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod a+r /docker-entrypoint-initdb.d/*

ENV DOCKERIZE_VERSION v0.8.0

RUN apt-get update \
    && apt-get install -y wget \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apt-get autoremove -yqq --purge wget && rm -rf /var/lib/apt/lists/*

RUN dockerize -wait tcp://db:3306
RUN npm run build

EXPOSE 8080
CMD ["npm", "start"]
