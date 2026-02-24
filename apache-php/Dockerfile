FROM fedora:43
RUN dnf install httpd php -y -q && \
    dnf clean all
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]