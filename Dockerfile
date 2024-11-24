FROM openjdk:18
RUN mkdir /app
COPY user-service/target/user-service-1.0.0.jar /app/user-service-1.0.0.jar
CMD ["java","-jar","/app/user-service-1.0.0.jar","&"]