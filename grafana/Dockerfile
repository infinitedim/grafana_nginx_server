FROM grafana/grafana:latest

# Set user ke root untuk setup
USER root

# Create necessary directories and set permissions
RUN mkdir -p /var/lib/grafana /var/log/grafana /etc/grafana && \
  chmod 755 /var/lib/grafana /var/log/grafana /etc/grafana

# Switch back to grafana user
USER grafana

# Expose Grafana port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:4000/api/health || exit 1