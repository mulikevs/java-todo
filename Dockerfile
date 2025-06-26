# Build stage
FROM gradle:7.6.0-jdk8 AS builder

WORKDIR /app

COPY build.gradle ./
COPY src ./src

RUN gradle clean installDist --no-daemon

# Runtime stage
FROM openjdk:8-jre-slim

WORKDIR /app

COPY --from=builder /app/build/install/todo .

EXPOSE 4567

CMD ["bin/todo"]