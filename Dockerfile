# hadolint ignore=DL3007
FROM alpine:latest

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3018
RUN apk add --no-cache openssh ca-certificates sudo vim        \
    && addgroup -S user && adduser -S user -G user -s /bin/ash \
    && echo "user    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  \
    && echo "user:password" | chpasswd                         \
    && mkdir -p /home/user/.ssh/                               \
    && ssh-keygen -o -a 100 -t ed25519 -f "/home/user/.ssh/id_ed25519" -N "" \
    && /usr/bin/ssh-keygen -A                                   

COPY --chown=user:user authorized_keys /home/guest/.ssh/authorized_keys

EXPOSE 22/tcp

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
