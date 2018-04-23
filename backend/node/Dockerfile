# Latest LTS of NodeJS
FROM node:carbon

# NodeJS App Directory
WORKDIR /usr/src/app

# Copy package.json aswell as package-lock.json
COPY package*.json ./
RUN npm install

COPY . .
EXPOSE 8080

CMD [ "npm", "start" ]