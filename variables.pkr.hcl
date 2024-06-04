variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_name_prefix" {
  type    = string
  default = "csye7125-jenkins"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "volume_size" {
  type    = number
  default = 40
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "ami-jenkins"
  }
}

variable "source_ami" {
  type    = string
  default = "ami-0a24670a6532ea110"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ami_description" {
  type    = string
  default = "Jenkins with caddy on Ubuntu LTS"
}

variable "domain" {
  type = string
  validation {
    condition     = var.domain != null && length(var.domain) > 0
    error_message = "Domain cannot be empty."
  }
}

variable "email" {
  type = string
  validation {
    condition     = var.email != null && length(var.email) > 0
    error_message = "Email cannot be empty."
  }
}

variable "jenkins_user" {
  type = string
  validation {
    condition     = var.jenkins_user != null && length(var.jenkins_user) > 0
    error_message = "Jenkins user cannot be empty."
  }
}

variable "jenkins_password" {
  type      = string
  sensitive = true
  validation {
    condition     = var.jenkins_password != null && length(var.jenkins_password) > 0
    error_message = "Jenkins password cannot be empty."
  }
}

variable "docker_hub_username" {
  type      = string
  sensitive = true
  validation {
    condition     = var.docker_hub_username != null && length(var.docker_hub_username) > 0
    error_message = "Docker Hub username cannot be empty."
  }
}

variable "docker_hub_password" {
  type      = string
  sensitive = true
  validation {
    condition     = var.docker_hub_password != null && length(var.docker_hub_password) > 0
    error_message = "Docker Hub password cannot be empty."
  }
}

variable "github_token" {
  type      = string
  sensitive = true
  validation {
    condition     = var.github_token != null && length(var.github_token) > 0
    error_message = "GitHub token cannot be empty."
  }
}

