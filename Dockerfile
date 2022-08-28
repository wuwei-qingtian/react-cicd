FROM nginx
LABEL name="react-front"
LABEL version="1.0"
COPY  ./build/ /usr/share/nginx/html/
COPY ./react-front.conf /etc/nginx/conf.d/
EXPOSE 80