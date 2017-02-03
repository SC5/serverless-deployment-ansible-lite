#!/usr/bin/env bash

# run ansible
docker run -v $(pwd):/src -w /src serverless-deployment /bin/bash -c "\
ansible-playbook -vvvv --inventory-file inventories/development/inventory site.yml"

[[ $? -eq 0 ]] || { echo "Build failed!" ; exit 1; }