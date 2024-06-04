source "amazon-ebs" "ubuntu" {
  region          = var.region
  ami_name        = "${var.ami_name_prefix}-{{timestamp}}"
  ami_description = var.ami_description
  tags            = var.tags
  instance_type   = var.instance_type
  source_ami      = var.source_ami
  ssh_username    = var.ssh_username
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive"
    ]
    scripts = [
      "scripts/install-dependencies.sh",
      "scripts/install-jenkins.sh",
      "scripts/install-caddy.sh",
      "scripts/install-docker.sh"
    ]
  }

  provisioner "file" {
    source      = "scripts/jenkins/"
    destination = "/var/lib/jenkins/casc_configs/"
  }


  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "DOMAIN=${var.domain}",
      "EMAIL=${var.email}",
      "JENKINS_USER=${var.jenkins_user}",
      "JENKINS_PASSWORD=${var.jenkins_password}",
      "DOCKER_HUB_USERNAME=${var.docker_hub_username}",
      "DOCKER_HUB_PASSWORD=${var.docker_hub_password}",
      "GITHUB_TOKEN=${var.github_token}"
    ]
    scripts = [
      "scripts/setup-jenkins.sh",
      "scripts/setup-caddy.sh",
      "scripts/setup-docker.sh"
    ]
  }

}
