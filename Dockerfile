FROM maven:3.6.3
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN ls -R /app
CMD ["ls", "-R", "/app"]
