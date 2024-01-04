FROM alpine:latest AS build
ARG BASE_URL=http://localhost
ARG HUGO_ENV=development
ARG COMENTARIO_BASE_URL="http://localhost:8080"

ENV HUGO_PARAMS_env=${HUGO_ENV}
ENV HUGO_PARAMS_comentarioBaseUrl=${COMENTARIO_BASE_URL}
ENV HUGO_BASEURL=${BASE_URL}

RUN apk add --update hugo git
WORKDIR /opt/HugoApp
COPY . .
RUN env && hugo

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /opt/HugoApp/public .
EXPOSE 80/tcp
