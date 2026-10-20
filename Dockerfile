FROM gradle:7.3.1-jdk17@sha256:4c6efa1d6a79c15a6a03f8396f0779f294a647ee75d325ae159fef9c778e35ad AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle bootJar --no-daemon


FROM openjdk:8u181-jdk-alpine@sha256:d146ac4892198bfef92e2d246e5b2b17894056ce9534ae0a2837c8d2920c2053
EXPOSE 8080
RUN mkdir /app
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-boot-application.jar
CMD ["java", "-jar", "/app/spring-boot-application.jar"]
