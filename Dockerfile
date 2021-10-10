FROM debian:bullseye-slim@sha256:753ead7d42d8f28fb2b6a0e20fac73505fb59c91974193c352f103bc6e50f654

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-pgbouncer

# install updates and dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends curl ca-certificates gnupg && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql-archive-bullseye.gpg && \
    echo -n "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/postgresql.list && \
    apt-get -q update && apt-get install -y --no-install-recommends pgbouncer && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/sbin/pgbouncer"]
