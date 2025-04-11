FROM node:18-alpine AS build
WORKDIR /app

RUN apk add --no-cache git

ARG GITHUB_USERNAME
ARG GITHUB_PAT
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=${REACT_APP_API_URL}
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_PAT}@github.com/Recetario-Cocol/ReactFrontend.git .


# Instala dependencias y genera el build
RUN npm install && npm run build

# -----------------------------
# Etapa final: imagen liviana para servir el build
FROM node:18-alpine
WORKDIR /app

# Instala 'serve' globalmente
RUN npm install -g serve

# Copia el build desde la etapa anterior
COPY --from=build /app/dist ./build

# Expone el puerto 3000 (interno)
EXPOSE 3000

# Comando de arranque
CMD ["serve", "-s", "build", "-l", "3000"]
