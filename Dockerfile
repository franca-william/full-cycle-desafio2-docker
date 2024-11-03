FROM node:14

WORKDIR /usr/src/app

COPY package*.json app.js ./

RUN npm install

EXPOSE 8080

CMD ["node", "app.js"]

#docker run -d -p 8080:8080 --name node-hello node-hello