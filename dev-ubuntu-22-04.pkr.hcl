packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "devbox-ubuntu-22-04" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  source_path  = "bento/ubuntu-20.04"
  insert_key   = true
}


build {
  sources = ["source.vagrant.devbox-ubuntu-22-04"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["apt update -y"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["apt upgrade -y"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive"
    ]
    scripts = [
      "scripts/ubuntu/disable-updates.sh",
      "scripts/ubuntu/base-packages.sh",

      "scripts/ubuntu/actionlint.sh",
      "scripts/ubuntu/ansible.sh",
      "scripts/ubuntu/awscliv2.sh",
      "scripts/ubuntu/azure-cli.sh",
      "scripts/ubuntu/docker.sh",
      "scripts/ubuntu/gcloud.sh",
      "scripts/ubuntu/gh-cli.sh",
      "scripts/ubuntu/golang-latest.sh",
      "scripts/ubuntu/helm.sh",
      "scripts/ubuntu/k0sctl.sh",
      "scripts/ubuntu/k9s.sh",
      "scripts/ubuntu/kubectx.sh",
      "scripts/ubuntu/python-3.8.sh",
      "scripts/ubuntu/yq-v4.40.5.sh",

      "scripts/ubuntu/clean-up.sh"
    ]
  }

}