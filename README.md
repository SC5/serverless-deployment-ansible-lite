# Example Ansible playbook for Ansible with Serverless

**Simple build and deploy playbook example**

Docker is required for deploying the playbook or alternatively Ansible and all the dependencies defined in Dockerfile.

When deploying from local environment AWS secrets needs to be passed to deployment container, for that e.g. `.deploy.sh` script in the project root with content of

```
#!/usr/bin/env bash

export AWS_ACCESS_KEY=my-access-key
export AWS_SECRET_KEY=my-secret-key

./scripts/deploy-local.sh

```

might ease up the deployment flow.

When using Jenkins on AWS EC2, use the role.


## Structure

* `group_vars` default variables
* `inventories` inventory files and variables for environments (developmen, production, etc.)
* `roles` ansible roles
  * `infra` role for infrastructure, vpc, database etc.
  * `service` role for Serverless service
* `scripts` scripts for that helps deployment

## Deployment

**Locally**

1. Build Dockerfile with `./scripts/build-docker.sh`
2. Run `./.deploy.sh`

**Jenkins**

[add pipeline job example]