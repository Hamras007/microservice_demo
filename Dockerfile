FROM alpine:latest
RUN apk update && apk add openjdk11
RUN mkdir /app
COPY user-service/target/