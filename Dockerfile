#Dockerfile for production environments
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#copy over the bare minimum over to nginx phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#default command of nginx image starts the image for us