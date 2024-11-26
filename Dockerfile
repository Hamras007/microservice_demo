FROM maven:3.6.1
RUN java --version
RUN mkdir /app
COPY user-service /app
WORKDIR /app
RUN pwd