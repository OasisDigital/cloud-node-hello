FROM node:10 as base

FROM base as builder
WORKDIR /usr/src/app
COPY package.json package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM base
WORKDIR /usr/src/app
COPY package.json package*.json ./
RUN npm install --only=production
COPY . .
COPY --from=builder /usr/src/app/build ./build

CMD [ "npm", "start" ]
# ENTRYPOINT [ "node", "build/server.js" ]
