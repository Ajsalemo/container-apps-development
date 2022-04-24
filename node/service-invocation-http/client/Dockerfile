FROM node:16.14.2-alpine3.15

WORKDIR /app/
COPY yarn.lock /app/

RUN yarn global add pm2 && yarn install

COPY . /app/

CMD [ "pm2", "start", "server.js", "--no-daemon", "-i", "0" ]

EXPOSE 3000