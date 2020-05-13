FROM node:13.8.0-alpine
WORKDIR /app/front

# system update
RUN apk update && \
    apk upgrade

ENV HOST 0.0.0.0
EXPOSE 8080
