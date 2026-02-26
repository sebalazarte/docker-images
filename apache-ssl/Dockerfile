# Base Fedora image that ships with dnf and systemd-friendly layout
FROM fedora:43

# Document puerto recomendado a publicar en el host (8443 → 443 interno)
ARG HOST_PORT=8443

# Metadata to document the built image in registries
LABEL version="1.0" \
      description="Apache HTTP Server with PHP y SSL on Fedora" \
    maintainer="Sebastian Lazarte <sebalazarte@outlook.com>" \
    preferred_host_port="${HOST_PORT}"

# Install Apache HTTPD and PHP, then clean cached rpm metadata
RUN dnf install httpd php php-cli openssl php-common mod_ssl -y -q && \
    dnf clean all

# Copy the custom Apache configuration file into the container
COPY ssl.conf /etc/httpd/conf.d/default.conf

# All subsequent file operations happen in Apache's docroot
WORKDIR /var/www/html

# Copy the SSL certificate and key into the container
COPY docker.crt /docker.crt
COPY docker.key /docker.key

# Copy the local site assets into the container docroot
COPY startbootstrap-sb-admin-2 .

COPY docker.crt /etc/pki/tls/certs/localhost.crt  
COPY docker.key /etc/pki/tls/private/localhost.key  

EXPOSE 443

# Launch Apache in the foreground so the container stays alive
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]