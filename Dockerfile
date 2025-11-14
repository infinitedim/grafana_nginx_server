# Alternative: Dockerfile di root untuk Railway
FROM docker:24-dind

# Install docker-compose
RUN apk add --no-cache curl bash py3-pip && \
  pip3 install docker-compose

WORKDIR /app

# Copy semua file project
COPY . .

# Make start.sh executable
RUN chmod +x start.sh

# Expose ports
EXPOSE 80 3000

# Start Docker daemon and run start.sh
CMD ["sh", "-c", "dockerd-entrypoint.sh & sleep 5 && ./start.sh"]