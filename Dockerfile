# Use Nginx to serve static HTML/CSS
FROM nginx:alpine

# Copy website files to Nginx html directory
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Nginx starts automatically
