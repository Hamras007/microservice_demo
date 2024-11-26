FROM maven:latest
RUN mvn --version
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd