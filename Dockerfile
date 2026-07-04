# Stage 1: build
FROM node:16-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: serve
FROM nginx:alpine
COPY --from=build /app/docs /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]