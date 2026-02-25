# Base Fedora image that ships with dnf and systemd-friendly layout
FROM fedora:43

# Metadata to document the built image in registries
LABEL version="1.0" \
      description="Apache HTTP Server with PHP on Fedora" \
      maintainer="Sebastian Lazarte <sebalazarte@outlook.com>"


# Install Apache HTTPD and PHP, then clean cached rpm metadata
RUN dnf install httpd php -y -q && \
    dnf clean all

# All subsequent file operations happen in Apache's docroot
WORKDIR /var/www/html

# Copy the local site assets into the container docroot
COPY beryllium .

# Default text to drop inside prueba.html, overridable at build time
ENV contenido=prueba

# Persist the ENV content and the current user (root) into HTML files
RUN echo "${contenido}" > ./prueba.html \
        && whoami > ./user1.html

# Create an unprivileged user and give ownership of the docroot
RUN useradd sebal \
    && chown -R sebal:sebal /var/www/html

# Drop privileges so future commands/web server run as sebal
USER sebal

# Confirm the non-root identity in a second HTML file
RUN whoami > ./user2.html

# Return to root for the final runtime command definition
USER root

# Launch Apache in the foreground so the container stays alive
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]