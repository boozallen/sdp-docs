FROM openjdk:8-jdk-alpine

VOLUME /tmp
#ARG JAR_FILE
COPY ./build/libs/gs-spring-boot-0.1.0.jar app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]