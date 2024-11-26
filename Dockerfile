FROM maven:3.9.9
RUN java --version
RUN mvn --version
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd
CMD ["mvn", "clean", "spring-boot:run"]