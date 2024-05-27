source "amazon-ebs" "ubuntu" {
  skip_create_ami = true # TODO: REMOVE THIS LINE
  region          = var.region
  ami_name        = var.ami_name
  ami_description = "Ubuntu setup with Jenkins"
  tags            = var.tags
  instance_type   = var.instance_type
  source_ami_filter {
    filters = {
      name                = var.source_ami_filter_name
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]
}
