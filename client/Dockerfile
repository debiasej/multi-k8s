# Build react app for production
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Use lightweight alpine version of nginx
FROM nginx
EXPOSE 3000

# Copy nginx config and app bundle to wwwroot
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html