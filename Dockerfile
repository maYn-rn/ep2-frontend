FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build


FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime

COPY --from=build /app/dist /usr/share/nginx/html

COPY docker/entrypoint.sh /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["sh","/entrypoint.sh"]
CMD ["nginx","-g","daemon off;"]
