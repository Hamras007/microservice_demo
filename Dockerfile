FROM alpine:latest
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd
CMD ["pwd"]
