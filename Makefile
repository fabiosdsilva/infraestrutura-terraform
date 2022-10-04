include .env

## Credenciais
ACCESS_KEY=${ACCESS_KEY_ID}
SECRET_ACCESS=${SECRET_ACCESS_KEY}

## Image docker
TERRAFORM_VERSION=light
DOCKER_IMAGE=hashicorp/terraform:${TERRAFORM_VERSION}

## Root module
PWD=$$PWD

## Workspace
WORKSPACE=${SET_WORKSPACE}

## Initial
terraform:
	docker run --rm -v ${PWD}:/app -w /app \
	-e AWS_ACCESS_KEY_ID=${ACCESS_KEY} \
	-e AWS_SECRET_ACCESS_KEY=${SECRET_ACCESS} \
	-it --entrypoint "" ${DOCKER_IMAGE} sh