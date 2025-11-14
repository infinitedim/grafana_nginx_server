FROM nginx:stable-alpine

# Install envsubst for environment variable substitution
RUN apk add --no-cache gettext

# Copy nginx config template
COPY default.conf /etc/nginx/templates/default.conf.template

# Create startup script
RUN echo '#!/bin/sh' > /docker-entrypoint.sh && \
  echo 'set -e' >> /docker-entrypoint.sh && \
  echo 'echo "🔧 Configuring nginx with:"' >> /docker-entrypoint.sh && \
  echo 'echo "GRAFANA_HOST=${GRAFANA_HOST}"' >> /docker-entrypoint.sh && \
  echo 'echo "GRAFANA_PORT=${GRAFANA_PORT}"' >> /docker-entrypoint.sh && \
  echo 'envsubst "\$GRAFANA_HOST \$GRAFANA_PORT" < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf' >> /docker-entrypoint.sh && \
  echo 'cat /etc/nginx/conf.d/default.conf' >> /docker-entrypoint.sh && \
  echo 'exec nginx -g "daemon off;"' >> /docker-entrypoint.sh && \
  chmod +x /docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]