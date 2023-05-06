# Setup

## Configure AWS CLI and Attach Necessary Credentials

```sh

Make IAM User with AdministratorAccess Policy on AWS console and generate an access key and secret key, then type that on command below.

```sh
aws configure
```

## Install Terraform (skip this step if already installed)

```sh
brew install terraform
```

## Generate SSH Key

```sh
mkdir .secrets
cd .secrets
ssh-keygen -t rsa
```

When prompted for a filename, fill it like below, and then press Enter, ignore the rest of these.

`Enter file in which to save the key (/Users/USERNAME/.ssh/id_rsa): minecraft.id_rsa`

## terraform init

## terraform plan

## terraform apply

## terraform graph (if you want to see the graph of the infrastructure)

```sh
brew install graphviz
terraform graph | dot -Tpng > graph.png
```

## Connect to the instance

```sh
ssh -i /Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft.pem ec2-user@13.115.191.144 -v
```

## Modify instance

```sh
aws ec2 stop-instances --instance-ids i-09a9de85bfaf851c5

aws ec2 start-instances --instance-ids i-09a9de85bfaf851c5
```

# Destroy

# プライベート
Host minecraft-server
    HostName 54.238.237.8
    User ec2-user
    IdentityFile /Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft.pem
