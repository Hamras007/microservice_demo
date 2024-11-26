FROM maven:3.8.1-openjdk-18
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd
CMD ["mvn", "clean", "spring-boot:run"]