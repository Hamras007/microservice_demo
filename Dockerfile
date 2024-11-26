FROM maven:3.6.3
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd
CMD ["mvn", "clean", "spring-boot:run"]