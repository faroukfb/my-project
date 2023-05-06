FROM node:alpine3.14 as build


WORKDIR /app

COPY package*.json /app/
RUN npm install

COPY  . /app/
RUN npm run build --prod

FROM nginx:alpine
RUN mkdir /etc/nginx/certs
COPY /ssl/server.crt /etc/nginx/certs/
COPY /ssl/server.key /etc/nginx/certs/ 
COPY --from=build /app/dist/project-name /usr/share/nginx/html
COPY /default.conf /etc/nginx/conf.d/default.conf
 EXPOSE 5001



CMD ["nginx", "-g", "daemon off;"]

