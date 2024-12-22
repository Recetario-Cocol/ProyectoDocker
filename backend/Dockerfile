FROM openjdk:17-jdk-slim
WORKDIR /app
ARG GITHUB_USERNAME
ARG GITHUB_TOKEN
RUN echo "GitHub Username: ${GITHUB_USERNAME}" && echo "GitHub Token: ${GITHUB_TOKEN}"
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/latronico96/springboot-jwt-auth.git .
RUN curl -o /app/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /app/wait-for-it.sh
RUN chmod +x ./mvnw && \
    ./mvnw clean package -DskipTests && \
    mv target/auth-api-0.0.1-SNAPSHOT.jar app.jar
RUN chmod +x ./wait-for-it.sh
EXPOSE 8005
ENTRYPOINT ["./wait-for-it.sh", "db:3306", "--", "java", "-jar", "/app/app.jar"]