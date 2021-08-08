# Build stage
FROM openjdk:11 AS base
WORKDIR /opt/hello-gradle
COPY ./ ./
RUN ./gradlew assemble

# Runtime stage
FROM amazoncorretto:11
WORKDIR /opt/hello-gradle
COPY --from=base /opt/hello-gradle/build/libs/hello-spring-test-0.0.1-SNAPSHOT.jar ./
CMD java -jar hello-spring-test-0.0.1-SNAPSHOT.jar
