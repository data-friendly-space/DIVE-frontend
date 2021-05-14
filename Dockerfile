FROM node:7 AS frontend-builder

WORKDIR /app

COPY package.json .
RUN npm install

ARG API_URL
ARG DEBUG
ARG NODE_ENV

ENV API_URL=$API_URL
ENV DEBUG=$DEBUG
ENV NODE_ENV=$NODE_ENV

COPY . /app/

RUN npm run-script build-production

################ Final build
FROM alpine:latest

COPY --from=frontend-builder /app/dist/ /app/dist/
