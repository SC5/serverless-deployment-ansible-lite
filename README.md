# Ansible Playbook for Ansible with Serverless

A simple build and deploy example for deploying [Serverless](https://github.com/serverless/serverless) service with [Ansible](https://github.com/ansible/ansible).

Docker is required for deploying the playbook or alternatively Ansible and all the dependencies defined in Dockerfile.

## Project Structure

* `group_vars` default variables
* `inventories` inventory files and variables for environments (development, production, etc.)
* `roles`
  * `infra` role for infrastructure, vpc, database etc.
  * `service` role for Serverless service
* `scripts` scripts that helps deployment

## Deployment

### Local environment

When deploying from local environment AWS secrets needs to be passed to deployment container, for that e.g. `.deploy.sh` script in the project root with contents of

```
#!/usr/bin/env bash

export AWS_ACCESS_KEY=my-access-key
export AWS_SECRET_KEY=my-secret-key
export SECRET=example-lambda-env-variable

./scripts/deploy-local.sh

```

might ease up the deployment flow.

1. Build Dockerfile with `./scripts/build-docker.sh`
2. Run `./.deploy.sh`

### Jenkins

When using Jenkins on AWS EC2, the role of the instance needs to have permissions to deploy CloudFormation stacks, create S3 buckets, IAM Roles, Lambda and other services that are used in Serverless service.

```
node {
    stage('Checkout repository') {
        git 'https://github.com/SC5/serverless-deployment-ansible-lite.git'
    }

    stage('Build Docker image') {
       sh "./scripts/build-docker.sh"
    }

    stage('Deploy') {
        withEnv(['SECRET=my-example-secret']) {
            sh './scripts/deploy-development.sh'
        }
    }
}
```

