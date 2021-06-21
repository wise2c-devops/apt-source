ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
FROM nginx:alpine
RUN mkdir /usr/share/nginx/html/debs
COPY debs /usr/share/nginx/html/debs
COPY index.html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
