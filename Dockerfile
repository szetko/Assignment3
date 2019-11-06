FROM ubuntu:16.04
# Dockerfiles always start with a FROM statement that specifies the base image type from which this container is built.

LABEL maintainer="<your name/email address>"
# This identifies the person responsible for this image.

RUN apt-get -q update && apt-get -yq dist-upgrade
RUN apt-get -yq install apache2
# RUN commands run their arguments as if they were entered into a shell inside the container.

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/run/apache
ENV APACHE_PID_FILE /var/run/apache/httpd.pid
RUN mkdir /var/run/apache
# ENV commands populate environment variables inside the container with values. This is a common way to pass configuration information to services running inside them.

ADD index.html /var/www/html/index.html
# This command will take a file named index.html from your build context and place a copy at the location specified inside the container. If the first argument to ADD is a directory, indicated by a trailing slash, then it will add the directory and its contents.

EXPOSE 80

# This will cause our container to open port 80 on the host system. Note that this doesn’t mean that the host’s port 80, or any other port, will be open or associated with the container’s port. This is done with the docker run comand.

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-DFOREGROUND"]
# The ENTRYPOINT specifies the command to run inside the container to start that process. The following CMD provides arguments to the ENTRYPOINT’s command.
# Since the ADD command specified an HTML file, you’ll need to place one inside your build context alongside the Dockerfile. This can just be a simple hello world page.

