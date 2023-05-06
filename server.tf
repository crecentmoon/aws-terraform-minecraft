/**
 * security group for minecraft server, allowing ssh and minecraft traffic
 */
resource "aws_security_group" "minecraft" {
    name = "minecraft"
    description = "minecraft"
    vpc_id = aws_vpc.minecraft.id

    ingress {
        description = "ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }

    ingress {
        description = "minecraft"
        from_port = 25565
        to_port = 25565
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}

resource "aws_ebs_volume" "minecraft" {
    availability_zone = "ap-northeast-1a"
    size              = 10
    type              = "gp3"

    tags = {
        Name = "minecraft"
    }
}

/**
 * ec2 instance for minecraft server, using Amazon Linux 2 AMI
 */
resource "aws_instance" "minecraft-server" {
    ami           = "ami-06560e4f1897491ed"
    instance_type = "t3a.medium" // 2 vCPU, 4 GiB
    key_name      = "minecraft"
    subnet_id     = aws_subnet.public-1.id
    security_groups = [aws_security_group.minecraft.id]
    associate_public_ip_address = true
    monitoring = true

    depends_on = [
        aws_key_pair.minecraft
    ]

    tags = {
        Name = "minecraft-server"
    }
}

resource "aws_volume_attachment" "minecraft" {
    device_name = "/dev/xvdf"
    volume_id   = aws_ebs_volume.minecraft.id
    instance_id = aws_instance.minecraft-server.id

    depends_on = [
        aws_instance.minecraft-server,
        aws_ebs_volume.minecraft
    ]
}
