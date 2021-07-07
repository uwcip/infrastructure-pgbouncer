FROM debian:bullseye-slim@sha256:0ed82c5d1414eacc0e97fda5656ed03cc06ab91c26cdeb54388403e440599a60

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-pgbouncer

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get install --no-install-recommends -y curl ca-certificates gnupg && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo -n "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/postgresql.list && \
    apt-get -q update && apt-get install --no-install-recommends -y pgbouncer && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/sbin/pgbouncer"]
