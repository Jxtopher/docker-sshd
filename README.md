# Dockerize sshd

Container with sshd service

Build the image
```bash
docker build . --tag srv
```

Launch the container in background
```bash
docker run -d -p 2222:22 --name srv srv
```

Connect in ssh to the container

```bash
ssh -i.\.ssh\id_rsa guest@192.168.0.151 -p 2222
```
