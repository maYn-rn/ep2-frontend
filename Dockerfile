# syntax=docker/dockerfile:1
#
# Dockerfile multi-stage (IE1) - React + Vite
# - Build stage: compila el frontend
# - Runtime stage: Nginx "unprivileged" (no root) sirviendo estáticos

FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build


FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime

# Archivos estáticos
COPY --from=build /app/dist /usr/share/nginx/html

# Script para generar /usr/share/nginx/html/env.js al iniciar el contenedor
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx","-g","daemon off;"]

