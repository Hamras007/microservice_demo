FROM maven:3.6.3
RUN mkdir /app
COPY user-service /app
WORKDIR /app/user-service
RUN ls -R /app
CMD ["ls", "-R"]
