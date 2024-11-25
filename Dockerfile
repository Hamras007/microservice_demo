FROM maven:latest
RUN mkdir /app
COPY ./user-service /app
WORKDIR /app
CMD ["mvn","clean","sprint-boot:run"]