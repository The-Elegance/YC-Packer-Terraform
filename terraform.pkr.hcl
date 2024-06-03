packer {
  required_plugins {
    yandex = {
      version = "~> 1"
      source  = "github.com/hashicorp/yandex"
    }
  }
}

variable "token" {
        type = string
        default = "<token>"
}

variable "folder_id" {
        type = string
        default = "<folder-id>"
}

variable "subnet_id" {
        type = string
        default = "<subnet_id>"
}

variable "TF_VER" {
  type = string
  default = "1.8.3"
}

source "yandex" "yc-terraform" {
  token               = "${var.token}"
  folder_id           = "${var.folder_id}"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = "true"
  image_description   = "Ubuntu with terraform for devops"
  image_family        = "ubuntu-2004-lts"
  image_name          = "yandex-ubuntu-terraform"
  subnet_id           = "${var.subnet_id}"
  disk_type           = "network-ssd"
  zone                = "ru-central1-d"
}

build {
  sources = ["source.yandex.yc-terraform"]

  provisioner "shell" {
    inline = [
      # Global Ubuntu things
      "sudo apt update",
      "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
      "sudo apt install -y unzip python3-pip python3.8-venv",

      # Yandex Cloud CLI tool
      "curl -s -O https://storage.yandexcloud.net/yandexcloud-yc/install.sh",
      "chmod u+x install.sh",
      "sudo ./install.sh -a -i /usr/local/ 2>/dev/null",
      "rm -rf install.sh",
      "sudo sed -i '$ a source /usr/local/completion.bash.inc' /etc/profile",

      # Terraform
      "curl -sL https://hashicorp-releases.yandexcloud.net/terraform/${var.TF_VER}/terraform_${var.TF_VER}_linux_amd64.zip",
      "unzip terraform.zip",
      "sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform",
      "rm -rf terraform terraform.zip",

      # Clean
      "rm -rf .sudo_as_admin_successful",

      # Test - Check versions for installed components
      "echo '=== Tests Start ==='",
      "yc version",
      "terraform version",
      "echo '=== Tests End ==='"
    ]
  }
}
