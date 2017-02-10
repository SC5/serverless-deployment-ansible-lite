# Ansible Playbook for Serverless Framework

A simple build and deploy example for deploying [Serverless](https://github.com/serverless/serverless) service with [Ansible](https://github.com/ansible/ansible).

Docker is required for deploying the playbook or alternatively Ansible and all the dependencies defined in Dockerfile installed in you environment.

For bigger scale Serverless projects there is also a more advanced version [serverless-deployment-ansible](https://github.com/SC5/serverless-deployment-ansible) that deploys Serverless service from built artifacts.

## Project Structure

* `group_vars` default variables
* `inventories` inventory files and variables for environments (development, production, etc.)
* `roles`
  * `infra` role for infrastructure, vpc, database etc.
  * `service` role for Serverless service
* `scripts` scripts that helps deployment

## Setup Jenkins

When using jenkins for deployment, easiest way is to setup Jenkins into EC2 instance running in your AWS account. Here is quick and dirty instructions how to do that [Jenkins setup instructions](https://github.com/laardee/jenkins-installation)

In addition to suggested plugins, install following plugins also:

* Pipeline: AWS Steps
* Version Number Plug-In

## Deployment

## Deployment flow

![deployment flow](https://raw.githubusercontent.com/SC5/serverless-deployment-ansible-lite/master/flow.png)

1. Get services from git, S3 bucket or other places with Ansible
2. Deploy Serverless service with Ansible Serverless module
3. Deploy other services, e.g. copy frontend files to buckets, deploy CloudFormation stacks

### Local environment

When deploying from local environment AWS secrets needs to be passed to deployment container, for that e.g. `.deploy.sh` script in the project root with contents of

```Bash
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

```Groovy
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

