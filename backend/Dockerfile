FROM node:carbon

EXPOSE 3000

WORKDIR /app
COPY . /app/
RUN npm install

CMD sleep 10 && cd /app && npm start
