# Step 1: Build the Java project
FROM maven:3.8.1-openjdk-11-slim AS builder

# Set the working directory
WORKDIR /src

# Copy the Maven configuration files to the container
COPY ./pom.xml ./pom.xml

# Download all dependencies. Dependencies will be cached if the pom.xml file is not changed.
RUN mvn dependency:go-offline

# Copy local code to the container image.
COPY ./src ./src

# Build the project
RUN mvn clean package

RUN ls ./target

# Step 2: Run the Java application
FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -y curl

# Copy the JAR file from the build stage
COPY --from=builder /src/target/java-hello-world-1.0-SNAPSHOT.jar /app/java-hello-world.jar

# Set the working directory
WORKDIR /app

# Command to run the application
ENTRYPOINT ["java", "-jar", "java-hello-world.jar"]

# Expose the necessary port (if your app serves HTTP, for example)
EXPOSE 8084

# Adjust the healthcheck to match your app's behavior
HEALTHCHECK --interval=15s --timeout=3s \
    CMD curl --fail http://localhost:8084/_health || exit 1

