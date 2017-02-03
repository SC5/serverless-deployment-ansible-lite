FROM ubuntu:16.04

MAINTAINER Eetu Tuomala <eetu.tuomala@sc5.io>

RUN apt-get autoclean
RUN apt-get update -y
RUN apt-get install --fix-missing build-essential \
  libssl-dev \
  software-properties-common \
  python \
  python-pip \
  git -y

RUN pip install --upgrade pip
RUN pip install git+git://github.com/ansible/ansible.git@devel awscli boto boto3 pyyaml

ENV NVM_DIR /usr/local/nvm

RUN /bin/bash -c 'wget -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash \
  && source $NVM_DIR/nvm.sh \
  && nvm install v4.3.2 \
  && npm install serverless -g'

ENV NODE_PATH $NVM_DIR/versions/node/v4.3.2/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v4.3.2/bin:$PATH
