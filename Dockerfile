FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008,DL3042
RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y openssh-server sudo vim ca-certificates git \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd \
    && useradd -m -s /bin/bash guest \
    && echo "guest    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo "guest:password" | chpasswd \
    && mkdir -p /home/guest/.ssh/ \
    && ssh-keygen -t rsa -b 4096 -q -f "/home/guest/.ssh/id_rsa" -N "" \
    && chmod 660 /etc/sudoers && echo "user ALL=NOPASSWD: ALL" >> /etc/sudoers && chmod 400 /etc/sudoers

COPY --chown=guest:guest authorized_keys /home/guest/.ssh/authorized_keys

EXPOSE 22/tcp

ENTRYPOINT ["/bin/sh","-c", "/usr/sbin/sshd -E /var/log/auth.log && tail -f /var/log/auth.log"]
