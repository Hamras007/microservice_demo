FROM maven:3.6.3
USER root
RUN mkdir /app
COPY user-service /app
USER maven
CMD ["ls", "-R", "/app/user-service"]
