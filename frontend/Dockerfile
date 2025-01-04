FROM node:latest
WORKDIR /app
ARG GITHUB_USERNAME
ARG GITHUB_PAT
ARG REACT_APP_API_URL
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_PAT}@github.com/Recetario-Cocol/ReactFrontend.git .
RUN npm install
RUN npm run build
EXPOSE 80
CMD ["npm", "start"]