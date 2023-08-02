# Use an official PHP image with PHP 8.1
FROM php:8.1-fpm

# Set the working directory within the container
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

RUN apt-get update && apt-get install -y \
    zip \
    unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the application files into the container
COPY . .

# Install application dependencies
RUN composer install

# Expose the port the web server will listen on
EXPOSE 9000

# Command to start the PHP-FPM process
CMD ["php-fpm"]
