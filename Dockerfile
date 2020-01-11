FROM python:latest
MAINTAINER Mike Petersen <mike@odania-it.de>

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose

RUN useradd -m -r -s /bin/bash app
USER app
WORKDIR /app
ENV PATH /usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/app/.local/bin

# Install awscli
RUN pip install awscli --upgrade --user
