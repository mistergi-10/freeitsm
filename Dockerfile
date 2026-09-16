FROM php:8.4-apache

# Enable required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the document root
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Container detection flag
ENV FREEITSM_CONTAINER=1
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Allow .htaccess overrides
RUN sed -i '/^<Directory \/var\/www\/>/,/^<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Create placeholder app directory
WORKDIR /var/www/html
RUN mkdir -p /var/www/html/tickets/attachments \
    /var/www/html/change-management/attachments \
    /var/www/encryption_keys \
    && chown -R www-data:www-data /var/www/html /var/www/encryption_keys \
    && chmod -R 755 /var/www/html \
    && chmod 700 /var/www/encryption_keys

# Create a simple placeholder if no source is mounted
RUN echo "<?php echo 'FreeITSM is running'; ?>" > /var/www/html/index.php

EXPOSE 80

CMD ["apache2-foreground"]
