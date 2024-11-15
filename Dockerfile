FROM node:14-alpine

WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./

RUN npm cache clean --force
RUN npm install

COPY ./ ./
COPY init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod a+r /docker-entrypoint-initdb.d/*

RUN npm run build

EXPOSE 8080
CMD ["npm", "start"]
