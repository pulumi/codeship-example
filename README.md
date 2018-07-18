# Deploying Pulumi Applications with CodeShip Pro

This repository demonstrates how to use [CodeShip Pro](https://codeship.com/features/pro) to deploy a [Pulumi](https://pulumi.io) application. In this example we use the [Video Thumbnailer](https://github.com/pulumi/examples/tree/master/cloud-js-thumbnailer) example application.

## Setting Up Pulumi for CodeShip Pro

The `[Dockerfile](./Dockerfile)` describes how to build the environment CodeShip Pro will do our deployment in. Starting from the `node:8` base image, we add Pulumi as well as install Docker (since the Pulumi deployment will run `docker build` to build the container for part of our application). Because we use `docker` we need to ensure we add the `add_docker: true` directive in our `codeship-services.yml` file.

In addition to the container, we need some environment variaibles present at deployment time. The ones we care about are:

 - `PULUMI_ACCESS_TOKEN`: This is an access token to allow us to use `pulumi` during deployment. You can generate one from on the in the [Pulumi Web Console](https://app.pulumi.com/account/tokens).
 - `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: These environment variaibles allow access to your AWS account.
 
We store these environment variables and their values in [`env.encrypted`](./env.encrypted), this was generated using `jet encrypt` per [CodeFlow Pro's Documentation](https://documentation.codeship.com/pro/builds-and-configuration/environment-variables/#encrypted-environment-variables). Our `codeship-services.yml` sets the `encrypted_env_file` property because of this.

## Doing a deployment

A small script [`deploy.sh`](./deploy.sh) manages the deployment and is added to the Docker container we do our build in. The first argument to the script should be either `preview` or `update`, and is passed to `pulumi` as the action. Any remaning arguments are passed as additional command line arguments to the tool. This script assumes a branch based workflow where `master`, `staging` and `production` map to different environments, and we use the `CI_BRANCH` environment variaible to determine one which environment to target.

In addition, this example leverages manual steps in CodeFlow Pro that updates to `staging` and `production` require an owner to approve them first. Before pausing the build for manual approval, we run a `pulumi preview` so that an operator can see the potential impact of the update in the build log.


