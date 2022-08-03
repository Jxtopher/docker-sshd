# hadolint ignore=DL3007
FROM alpine:latest

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3042,DL3018 
RUN apk add --no-cache openssh ca-certificates sudo vim        \
    && addgroup -S user && adduser -S user -G user -s /bin/ash \
    && echo "user    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  \
    && echo "user:password" | chpasswd                         \
    && mkdir -p /home/user/.ssh/                               \
    && ssh-keygen -t rsa -b 4096 -q -f "/home/user/.ssh/id_rsa" -N "" \
    && /usr/bin/ssh-keygen -A                                   

COPY --chown=guest:guest authorized_keys /home/guest/.ssh/authorized_keys

EXPOSE 22/tcp

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
