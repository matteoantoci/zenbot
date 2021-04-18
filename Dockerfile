FROM node:12

ADD package.json /app
ADD package-lock.json /app
WORKDIR /app
RUN npm install -g node-gyp
RUN npm ci --unsafe

FROM node:12-alpine

COPY zenbot.sh /usr/local/bin/zenbot

WORKDIR /app
RUN chown -R node:node /app

COPY --chown=node . /app
COPY --chown=node --from=builder /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
COPY --chown=node --from=builder /app/node_modules /app/node_modules/

USER node
ENV NODE_ENV production

ENTRYPOINT ["/usr/local/bin/zenbot"]
CMD ["trade","--paper"]
