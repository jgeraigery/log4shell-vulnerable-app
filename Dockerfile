FROM gradle:9.8.2-jdk17@sha256:55af4a989cc9188c19668b32e52bbd2a0c801da3b849a6e8f5a25e2134845bf5 AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle bootJar --no-daemon


FROM openjdk:8u181-jdk-alpine
EXPOSE 8080
RUN mkdir /app
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-boot-application.jar
CMD ["java", "-jar", "/app/spring-boot-application.jar"]
