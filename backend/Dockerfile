FROM openjdk:17-jdk-slim
WORKDIR /app
ARG GITHUB_USERNAME
ARG GITHUB_PAT
ARG SPRING_DATASOURCE_URL
ARG SPRING_DATASOURCE_USERNAME
ARG SPRING_DATASOURCE_PASSWORD
ARG CORS_ALLOWED_ORIGIN

# Usa los ARG en la construcción o configura como variables de entorno
ENV GITHUB_USERNAME=${GITHUB_USERNAME}
ENV GITHUB_PAT=${GITHUB_PAT}
ENV SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
ENV SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
ENV CORS_ALLOWED_ORIGIN=${CORS_ALLOWED_ORIGIN}
ENV SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}

RUN echo "GitHub Username: ${GITHUB_USERNAME}" && echo "GitHub Token: ${GITHUB_PAT}"

# Instala dependencias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    libcurl4-openssl-dev \
    perl \
    liberror-perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Clona el repositorio de GitHub
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_PAT}@github.com/Recetario-Cocol/hub .

# Espera a que la base de datos esté lista
RUN curl -o /app/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /app/wait-for-it.sh

# Compila el proyecto
RUN chmod +x ./mvnw && \
    ./mvnw clean package -DskipTests && \
    mv target/auth-api-0.0.1-SNAPSHOT.jar app.jar

# Espera a que la base de datos esté lista
RUN chmod +x ./wait-for-it.sh

EXPOSE 8005

ENTRYPOINT ["./wait-for-it.sh", "database:3306", "--", "java", "-jar", "/app/app.jar"]
