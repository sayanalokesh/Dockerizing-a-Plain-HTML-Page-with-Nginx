FROM nginx:latest

# Copy your custom Nginx configuration file
COPY reverseproxy /etc/nginx/sites-available/reverseproxy

# Create directories if they don't exist
RUN mkdir -p /etc/nginx/sites-enabled && \
    ln -s /etc/nginx/sites-available/reverseproxy /etc/nginx/sites-enabled/

# Copy HTML file to serve
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
