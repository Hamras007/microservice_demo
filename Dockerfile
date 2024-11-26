FROM openjdk:18
RUN apt-get update && apt-get install -y maven
mvn --version
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd