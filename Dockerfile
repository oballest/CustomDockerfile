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


RUN yum install -y httpd && \
    yum clean all --noplugins -y


RUN chgrp -R 0 /etc/httpd/logs/ && \
    chgrp -R 0 /run/httpd/ && \
    chmod -R g=u /etc/httpd/logs/ /run/httpd/ && \
    sed -ri -e '/^Listen 80/c\Listen 8080' /etc/httpd/conf/httpd.conf

ONBUILD COPY ./src/ /var/www/html/

EXPOSE 8080

USER 1001

CMD ["httpd","-D","FOREGROUND"] 

