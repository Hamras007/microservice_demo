FROM maven:3.6.3
RUN mkdir /app
COPY ./user-service /app
WORKDIR /app
CMD ["mvn","clean","sprint-boot:run"]