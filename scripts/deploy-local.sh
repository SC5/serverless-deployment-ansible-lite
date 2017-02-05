#!/usr/bin/env bash

# run ansible
docker run -v $(pwd):/src -w /src serverless-deployment /bin/bash -c "\
export AWS_ACCESS_KEY=$AWS_ACCESS_KEY && \
export AWS_SECRET_KEY=$AWS_SECRET_KEY && \
export SECRET=$SECRET && \
serverless config credentials --provider aws --key $AWS_ACCESS_KEY --secret $AWS_SECRET_KEY && \
ansible-playbook -vvvv --inventory-file inventories/development/inventory site.yml"

[[ $? -eq 0 ]] || { echo "Build failed!" ; exit 1; }