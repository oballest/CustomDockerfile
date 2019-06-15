FROM centos:7.3.1611

LABEL Component="httpd" \ 
      Name="do288/httpd-parent" \
      Version="1.0" \
      Release="1"

MAINTAINER Oscar Ballesteros oballest@redhat.com

# Labels consumed by OpenShift
LABEL io.k8s.description="A basic Apache HTTP Server image with ONBUILD instructions" \
      io.k8s.display-name="Apache HTTP Server parent image" \
      io.openshift.expose-services="80:http" \
      io.openshift.tags="apache, httpd"


RUN yum update -y && \
    yum install -y httpd


RUN chmod 755 /etc/httpd/logs/ && \
    chmod 755 /run/httpd/


EXPOSE 80

CMD ["httpd","-D","FOREGROUND"] 

