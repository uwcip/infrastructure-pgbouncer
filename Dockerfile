FROM debian:bullseye-slim@sha256:5cf1d98cd0805951484f33b34c1ab25aac7007bb41c8b9901d97e4be3cf3ab04 AS base

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
