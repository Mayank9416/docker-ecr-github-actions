# Use a multi-stage build for a smaller final image
FROM openjdk:11-jre-slim AS builder

# Set the working directory to /app
WORKDIR /app

# Copy the source code into the container
COPY . .

# Compile the application
RUN javac HelloWorld.java

# Create a minimal JRE image to run the application
FROM openjdk:11-jre-slim

# Set the working directory to /app
WORKDIR /app

# Copy only the compiled application from the builder stage
COPY --from=builder /app/HelloWorld.class .

# Run the application
CMD ["java", "HelloWorld"]
