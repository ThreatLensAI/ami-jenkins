# CSYE7125 Jenkins AMI using Packer

This repository contains configurations and scripts to build a Jenkins AMI using Packer.

## Installing Packer

To install Packer, follow these steps:

1. Go to the [Packer website](https://www.packer.io/downloads).
2. Download the appropriate version for your operating system.
3. Extract the downloaded archive to a directory included in your system's PATH.
4. Verify the installation by running `packer --version` in your terminal.

## Initializing Packer

Before building the image, you need to initialize Packer. This step ensures that Packer can detect and use the required plugins.

To initialize Packer, run the following command in your terminal:

    packer init .

## Building the Image

Once Packer is initialized, you can build the custom image using the provided `.hcl` file.

To build the image, run the following command in your terminal:

    packer build -color=false .
