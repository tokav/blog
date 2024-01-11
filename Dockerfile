FROM alpine:latest AS build

ARG HUGO_ENV=development
ENV HUGO_PARAMS_env=${HUGO_ENV}

RUN apk add --update hugo git
WORKDIR /opt/HugoApp
COPY . .
RUN env && hugo

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /opt/HugoApp/public .
EXPOSE 80/tcp
