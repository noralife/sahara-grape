FROM nginx
MAINTAINER Tatsuya Nanjo <noralife@gmail.com>
WORKDIR /usr/share/nginx/html
ADD . /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
