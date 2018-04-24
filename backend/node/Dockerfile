FROM node:carbon

EXPOSE 3000

WORKDIR /app
COPY . /app/
RUN npm install

ENTRYPOINT cd /app && npm start
