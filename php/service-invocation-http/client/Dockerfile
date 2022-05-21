FROM php:8.1-apache-buster

ENV APP_ENV=production
ENV APP_DEBUG=false

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/html/www/
COPY . /var/html/www/
COPY ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./apache/apache2.conf /etc/apache2/apache2.conf

RUN composer validate --no-check-publish && \
    composer install --prefer-dist --no-progress 

EXPOSE 80


