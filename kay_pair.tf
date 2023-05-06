variable "key_name" {
    type = string
    default = "minecraft"
}

locals {
    public_key = "/Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft_rsa.pub" // Change this to your own path
    private_key = "/Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft_rsa" // Change this to your own path
    pem = "/Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft.pem" // Change this to your own path
}

resource "tls_private_key" "minecraft" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "local_file" "minecraft_public_key" {
    filename = local.public_key
    content  = tls_private_key.minecraft.public_key_openssh

    provisioner "local-exec" {
        command = "chmod 777 ${local.public_key}"
    }
}

resource "local_file" "minecraft_private_key" {
    filename = local.private_key
    content  = tls_private_key.minecraft.private_key_pem

    provisioner "local-exec" {
        command = "chmod 777 ${local.private_key}"
    }
}

resource "aws_key_pair" "minecraft" {
    key_name   = var.key_name
    public_key = tls_private_key.minecraft.public_key_openssh

    depends_on = [
        tls_private_key.minecraft,
        local_file.minecraft_private_key,
        local_file.minecraft_public_key
    ]
}

resource "local_file" "pem" {
    filename = local.pem
    content = local_file.minecraft_private_key.content

    depends_on = [
        aws_key_pair.minecraft
    ]

    provisioner "local-exec" {
        command = "chmod 600 ${local.pem}"
    }
}