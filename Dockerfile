FROM node:16-alpine

RUN apk add --no-cache python3 py3-pip make g++

WORKDIR /app

COPY feeder/package*.json ./feeder/
RUN cd feeder && npm i --production

COPY price-server/package*.json ./price-server/
RUN cd price-server && npm i --production

COPY feeder feeder
COPY price-server price-server

RUN addgroup -g 1001 app
RUN adduser -D -G app -u 1001 app

USER app

ENTRYPOINT [ "npm", "start", "--prefix" ]
# CMD [ "feeder", "vote" ]
