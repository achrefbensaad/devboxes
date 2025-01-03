packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

variable "hcp_client_id" {
  type    = string
  default = "${env("HCP_CLIENT_ID")}"
}

variable "hcp_client_secret" {
  type    = string
  default = "${env("HCP_CLIENT_SECRET")}"
}


source "vagrant" "devbox-ubuntu-22-04" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  source_path  = "bento/ubuntu-22.04"
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

      "scripts/ubuntu/act.sh",
      "scripts/ubuntu/actionlint.sh",
      "scripts/ubuntu/ansible.sh",
      "scripts/ubuntu/awscliv2.sh",
      "scripts/ubuntu/azure-cli.sh",
      "scripts/ubuntu/bash-completion.sh",
      "scripts/ubuntu/bpftool.sh",
      "scripts/ubuntu/docker.sh",
      "scripts/ubuntu/doctl.sh",
      "scripts/ubuntu/gcloud.sh",
      "scripts/ubuntu/gh-cli.sh",
      "scripts/ubuntu/golang-latest.sh",
      "scripts/ubuntu/helm.sh",
      "scripts/ubuntu/k0sctl.sh",
      "scripts/ubuntu/k9s.sh",
      "scripts/ubuntu/kubebuilder.sh",
      "scripts/ubuntu/kubectx.sh",
      "scripts/ubuntu/kustomize.sh",
      "scripts/ubuntu/llvm-toolchain.sh",
      "scripts/ubuntu/python-3.8.sh",
      "scripts/ubuntu/yq-v4.40.5.sh",

      "scripts/ubuntu/clean-up.sh"
    ]
  }


    post-processor "vagrant-registry" {
      client_id     = "${var.hcp_client_id}"
      client_secret = "${var.hcp_client_secret}"
      box_tag       = "devboxes/ubuntu-22-04"
      version       = "2024.12.8"
      architecture  = "amd64"
    }
}
