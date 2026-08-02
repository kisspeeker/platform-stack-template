# Stub
# Docs: https://hub.docker.com/_/nginx
FROM nginx:1.27-alpine
RUN sed -i 's/listen       80;/listen       3000;/' /etc/nginx/conf.d/default.conf
EXPOSE 3000
