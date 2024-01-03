ARG BASE_URL=http://localhost

FROM alpine:latest AS build

RUN apk add --update hugo git
WORKDIR /opt/HugoApp
COPY . .
ENV HUGO_BASEURL=${BASE_URL}
RUN hugo

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /opt/HugoApp/public .
EXPOSE 80/tcp
