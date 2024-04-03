[![Docker build](http://dockeri.co/image/wh1isper/aws-cli-pypi)](https://hub.docker.com/r/wh1isper/aws-cli-pypi)

**Build everyday, so you don't need to worry any outdated packages for security.**

Usage: Build your docker with aws codeartifact pypi access.

```Dockerfile
FROM wh1isper/aws-cli-pypi as awscli

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

# Use this to disable cache
ARG CACHE_FLAG
RUN aws codeartifact login --tool pip --repository morph-dev --domain morph --domain-owner 293550735226 --region us-west-2

FROM python:python:3.10.12-slim-bookworm

COPY --from=awscli /root/.config/pip/pip.conf /root/.config/pip/pip.conf

RUN pip install <YOUR_PACKAGE>
```

Build with args like:

```bash
docker build --build-arg AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID> --build-arg AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY> --build-arg CACHE_FLAG="$(date)" -t <YOUR_DOCKER_IMAGE> -f <YOUR_DOCKERFILE> .
```
