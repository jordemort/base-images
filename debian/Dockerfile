FROM debian:stretch-slim

LABEL maintainer="Jordan Webb <jordemort@github.com>"
LABEL LABEL org.label-schema.description="A slightly less slim debian:stretch-slim"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      dumb-init \
      gnupg2 \
      gosu \
      locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 \
                  LANGUAGE=en_US:en \
                  LC_ALL=en_US.UTF-8 && \
    apt-get clean

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

ENTRYPOINT [ "/usr/bin/dumb-init" ]
CMD [ "/bin/bash" ]
