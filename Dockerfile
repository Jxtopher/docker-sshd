# docker build . --tag srv
# docker run -d -p 2222:22 --name srv srv
# ssh -i.\.ssh\id_rsa guest@192.168.0.151 -p 2222
FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008,DL3042
RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y openssh-server sudo vim git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd \
    && useradd -m -s /bin/bash guest \
    && echo "guest    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# && echo "guest:password" | chpasswd \

COPY --chown=guest:guest authorized_keys /home/guest/.ssh/authorized_keys

ENTRYPOINT ["/bin/sh","-c", "/usr/sbin/sshd -E /var/log/auth.log && tail -f /var/log/auth.log"]
