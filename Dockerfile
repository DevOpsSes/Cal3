# Build Stage
FROM maven:3.6.3-jdk-11-slim AS build
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B clean package -DskipTests

# Deploy Stage
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /workspace/target/*.war /app/gitopsdemocalcproject.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/gitopsdemocalcproject.war"]
