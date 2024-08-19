# Jenkins AMI using Packer

This repository contains configurations and scripts to build a Jenkins AMI using Packer.

[![Create Image](https://github.com/cyse7125-su24-team06/ami-jenkins/actions/workflows/release.yml/badge.svg)](https://github.com/cyse7125-su24-team06/ami-jenkins/actions/workflows/release.yml)

## Installing Packer

To install Packer, follow these steps:

1. Visit [Packer website](https://www.packer.io/downloads) to download packer.
2. Download the appropriate version for your operating system.
3. Extract the downloaded archive to a directory included in your system's PATH.
4. Verify the installation by running `packer --version` in your terminal.

## Initializing Packer

Before building the image, you need to initialize Packer. This step ensures that Packer can detect and use the required plugins.

To initialize Packer, run the following command in your terminal:

    packer init .

## Building the Image

Once Packer is initialized, you can build the custom image using the provided `.hcl` files.

To build the image, run the following command in your terminal:

    echo "---Github App private key---" > github-app.pem # Update with your GitHub App private key

    export PKR_VAR_domain="example.com"                  # Update with your domain
    export PKR_VAR_email="email@example.com"             # Update with your email
    export PKR_VAR_jenkins_user="jenkins"                # Update with your Jenkins user
    export PKR_VAR_jenkins_password="password"           # Update with your Jenkins password
    export PKR_VAR_docker_hub_username="username"        # Update with your DockerHub username
    export PKR_VAR_docker_hub_password="password"        # Update with your DockerHub password
    export PKR_VAR_github_token="token"                  # Update with your GitHub token
    export PKR_VAR_github_app_id="app_id"                # Update with your GitHub app ID
    packer build -color=false .

In case you don't want to export the above variables, use the `-var` flag, it allows you to pass variables to the build process.
Required variables are:

- `domain` - The domain name to create SSL certificates for.
- `email` - The email address to use for ZeroSSL certificates.
- `jenkins_user` - The Jenkins user to create.
- `jenkins_password` - The password for the Jenkins user.
- `docker_hub_username` - The DockerHub username.
- `docker_hub_password` - The DockerHub password.
- `github_token` - The GitHub token.
- `github_app_id` - The GitHub app ID.

The github app private key must be export to the file `github-app.pem` as packer uses this file to create the GitHub App installation token.

## CI/CD Pipeline

The repository contains a GitHub Actions workflow that automatically builds the Jenkins AMI using Packer.

The workflow is triggered when a new commit is pushed to the `main` branch.

The workflow performs the following steps:

1. Initializes Packer.
2. Builds the Jenkins AMI using the provided `.hcl` files.

Required secrets for CI/CD pipeline are:

- `AWS_ACCESS_KEY_ID` - The AWS access key ID.
- `AWS_SECRET_ACCESS_KEY` - The AWS secret access key.
- PACKER Variables:
  - `PKR_VAR_domain` - The domain name to create SSL certificates for.
  - `PKR_VAR_email` - The email address to use for ZeroSSL certificates.
  - `PKR_VAR_jenkins_user` - The Jenkins user to create.
  - `PKR_VAR_jenkins_password` - The password for the Jenkins user.
  - `PKR_VAR_docker_hub_username` - The DockerHub username.
  - `PKR_VAR_docker_hub_password` - The DockerHub password.
  - `PKR_VAR_github_token` - The GitHub token.
  - `PKR_VAR_github_app_id` - The GitHub app ID.
  - `PKR_VAR_github_app_private_key` - The GitHub App private key.
