FROM node:14-alpine

WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./

RUN npm cache clean --force
RUN npm install

COPY ./ ./

RUN npm run build

EXPOSE 8080

CMD ["npm", "start"]

#docker run -d -p 8080:8080 --name node-hello node-hello