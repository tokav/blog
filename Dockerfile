ARG BASE_URL=http://localhost
ARG HUGO_ENV=development
ARG COMENTARIO_BASE_URL=http://localhost:8080

FROM alpine:latest AS build

RUN apk add --update hugo git
WORKDIR /opt/HugoApp
COPY . .
ENV HUGO_BASEURL=${BASE_URL}
ENV HUGO_PARAMS_env=${HUGO_ENV}
ENV HUGO_PARAMS_comentarioBaseUrl=${COMENTARIO_BASE_URL}
RUN hugo

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /opt/HugoApp/public .
EXPOSE 80/tcp
