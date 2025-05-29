ARG NODE_VERSION=19.0.0
FROM node:${NODE_VERSION}-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 9000

CMD ["npx", "nodemon", "src/index.js"]
