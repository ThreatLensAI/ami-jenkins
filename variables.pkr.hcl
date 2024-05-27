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

variable "domain" {
  type = string
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}
