FROM node:lts-alpine
RUN apk update && apk upgrade && apk add --no-cache bash git openssh python build-base

ADD . /app
COPY zenbot.sh /usr/local/bin/zenbot

WORKDIR /app

RUN npm install -g node-gyp
RUN npm ci --unsafe

RUN chown -R node:node /app

USER node
ENV NODE_ENV production

ENTRYPOINT ["/usr/local/bin/zenbot"]
CMD ["trade","--paper"]
