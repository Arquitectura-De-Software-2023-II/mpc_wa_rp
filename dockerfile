FROM nginx

RUN apt-get update -qq && apt-get -y install apache2-utils
ENV NODE_ROOT /var/www/web-frontend
WORKDIR $NODE_ROOT
RUN mkdir log
COPY app.conf /tmp/app.nginx
COPY server.crt /etc/nginx/ssl/certificate.crt
COPY server.key /etc/nginx/ssl/privateKey.key
RUN envsubst '$NODE_ROOT' < /tmp/app.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 5050

CMD ["nginx", "-g", "daemon off;"]