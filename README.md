# Dockerize sshd

Container with sshd service

Add your pub key in authorized_keys file
```bash
cat ~/.ssh/id_rsa
```

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
ssh -i ~/.ssh/id_rsa guest@192.168.0.151 -p 2222
```
