FROM ubuntu:latest

RUN apt update && apt install -y wget curl nginx

COPY index.html /var/www/html/index.html

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
                                   
