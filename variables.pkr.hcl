variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_name" {
  type    = string
  default = "csye7125-jenkins-{{timestamp}}"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "ami-jenkins"
  }
}

variable "source_ami_filter_name" {
  type    = string
  default = "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"
}

variable "domain" {
  type = string
}
