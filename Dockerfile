FROM maven:3.9.6-eclipse-temurin-21-alpine AS build

RUN mkdir /project

COPY . /project

# Passed from Github Actions
ARG GIT_VERSION_TAG=unspecified
ARG GIT_COMMIT_MESSAGE=unspecified
ARG GIT_VERSION_HASH=unspecified

WORKDIR /project

RUN mvn clean package

#FROM adoptopenjdk/openjdk21:eclipse-temurin-21-alpine
#FROM bellsoft/liberica-openjdk-debian:21
#FROM openjdk:21-slim
FROM amazoncorretto:21-alpine-jdk
LABEL maintainer="hendisantika@yahoo.co.id"

RUN mkdir /app

RUN addgroup -g 1001 -S hendigroup

RUN adduser -S hendi -u 1001
ENV PORT=9100
EXPOSE 9100
COPY --from=build /project/target/coffee-shop-1.0.0.jar /app/coffee-shop.jar

WORKDIR /app

RUN chown -R hendi:hendigroup /app

CMD java $JAVA_OPTS -jar coffee-shop.jar
