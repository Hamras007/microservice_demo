FROM maven:3.6.3
RUN mkdir /app
COPY user-service /app
WORKDIR /app/user-service
CMD ["mvn", "clean", "spring-boot:run", "-f", "/app/user-service"]