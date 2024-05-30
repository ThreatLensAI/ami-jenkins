# CSYE7125 Jenkins AMI using Packer

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

    export PKR_VAR_domain="example.com"         # Update with your domain
    export PKR_VAR_email="email@example.com"    # Update with your email
    packer build -color=false .

In case you don't want to export the above variables, use the `-var` flag, it allows you to pass variables to the build process.
Required variables are:

- `domain` - The domain name to create SSL certificates for.
- `email` - The email address to use for ZeroSSL certificates.

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
