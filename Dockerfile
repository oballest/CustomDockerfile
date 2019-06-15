FROM centos:7.3.1611

LABEL Component="httpd" \ 
      Name="do288/httpd-parent" \
      Version="1.0" \
      Release="1"

MAINTAINER Oscar Ballesteros oballest@redhat.com

# Labels consumed by OpenShift
LABEL io.k8s.description="A basic Apache HTTP Server image with ONBUILD instructions" \
      io.k8s.display-name="Apache HTTP Server parent image" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd"


RUN yum update -y && \
    yum install -y httpd


RUN chmod 755 /etc/httpd/logs/ && \
    chmod 755 /run/httpd/ && \
    sed -ri -e '/^Listen 80/c\Listen ${PORT}' /etc/httpd/conf/httpd.conf

ONBUILD COPY ./src/ /var/www/html/

EXPOSE 8080

CMD ["httpd","-D","FOREGROUND"] 

