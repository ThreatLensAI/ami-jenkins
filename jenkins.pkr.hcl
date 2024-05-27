source "amazon-ebs" "ubuntu" {
  region                      = var.region
  ami_name                    = var.ami_name
  ami_description             = "Ubuntu setup with Jenkins"
  tags                        = var.tags
  instance_type               = var.instance_type
  associate_public_ip_address = false

  # TODO: Filter on name or hardcoded AMI ID?
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
  # ami_users    = [""] TODO: Fill this
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    environment_vars = [
      "DOMAIN=${var.domain}",
    ]
    scripts = [
      "scripts/install-dependencies.sh",
      "scripts/install-jenkins.sh",
      "scripts/install-caddy.sh",
      "scripts/setup-caddy.sh"
    ]
  }
}
