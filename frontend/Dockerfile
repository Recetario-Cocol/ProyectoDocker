FROM node:18-alpine as build
WORKDIR /app
RUN apk add --no-cache git
ARG GITHUB_USERNAME
ARG GITHUB_PAT
ARG REACT_APP_API_URL
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_PAT}@github.com/Recetario-Cocol/ReactFrontend.git .
RUN npm install
RUN npm run build
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
