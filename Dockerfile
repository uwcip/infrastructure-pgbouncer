FROM debian:bullseye-slim@sha256:94133c8fb81e4a310610bc83be987bda4028f93ebdbbca56f25e9d649f5d9b83

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-pgbouncer

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get install --no-install-recommends -y curl ca-certificates gnupg && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo -n "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/postgresql.list && \
    apt-get -q update && apt-get install --no-install-recommends -y pgbouncer && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/sbin/pgbouncer"]
