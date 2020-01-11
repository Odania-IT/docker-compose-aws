FROM python:latest
MAINTAINER Mike Petersen <mike@odania-it.de>

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose
COPY dist /

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update \
	&& apt-get install -y docker-ce-cli

RUN useradd -m -r -s /bin/bash app
USER app
WORKDIR /app
ENV PATH /usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/app/.local/bin
ENV AWS_DEFAULT_REGION eu-central-1

# Install awscli
RUN pip install awscli --upgrade --user

