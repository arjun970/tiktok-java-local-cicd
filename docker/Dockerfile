# Use OpenJDK 11 as the base image
FROM openjdk:11

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file from the build context to the container
COPY target/tiktok-1.0-SNAPSHOT.jar app.jar

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
