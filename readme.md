# Setup

## Configure AWS CLI and Attach Necessary Credentials

Make IAM User with AdministratorAccess Policy on AWS console and generate an access key and secret key, then paste generated key on `aws configure`.

```sh
aws configure
```

## Install Terraform (skip this step if already installed)

To manage infrastructure as code, we use Terraform.

```sh
brew install terraform
```

or install tfenv at first if you want to manage multiple versions of terraform.

```sh
brew install tfenv
tfenv install latest
tfenv use latest
terraform --version
```

## Generate SSH Key

To access the server instance we will create from now on via SSH, you need to generate SSH key pair.
Make .sercrets directory and generate SSH key pair in it.

```sh
mkdir .secrets
cd .secrets
ssh-keygen -t rsa
```

When prompted for a filename, fill it like below, and then press Enter, ignore the rest of these.

`Enter file in which to save the key (/Users/USERNAME/.ssh/id_rsa): minecraft.id_rsa`

## terraform init

To initialize terraform, run `terraform init` command.

```sh
terraform init
```

## terraform plan

To see what resources will be created, run `terraform plan` command.

```sh 
terraform plan
```

## terraform apply

Before creating resources, please change the path to the SSH key pair you generated in the ``key_pair.tf` file.

To create resources, run `terraform apply` command.

```sh
terraform apply
```

By executing the above command, terraform will create and manage the resources which is necessary for the Minecraft server in ap-northeast-1(tokyo) region.

## terraform graph (if you want to see the graph of the infrastructure)

```sh
brew install graphviz
terraform graph | dot -Tpng > graph.png
```

# Install minecraft

This sample repository does not automate the installation of Minecraft server itself yet, so please install it manually.

You can use shellscript in a /setup directory to setup instance filesystem and installation of minecraft server.

## Connect to the instance

To connect to the instance, run the following command.

```sh
ssh -i /Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft.pem ec2-user@xxx.xxx.xxx.xxx -v // change the path to your SSH key pair path
```

or add the following to `~/.ssh/config` and connect with `ssh minecraft-server`.

```sh
Host minecraft-server
    HostName xxx.xxx.xxx.xxx // change this ip to your instance's public ip
    User ec2-user
    IdentityFile /Users/tsukiokayuu/Documents/terraform-minecraft/.secrets/minecraft.pem // change this path to your SSH key pair path
```

## Instance operation via AWS CLI

It gets pricey if you leave the instance running all the time, so please stop the instance when you don't play Minecraft.

```sh // change this instance id to your instance id
aws ec2 start-instances --instance-ids i-09a9de85bfaf851c5
aws ec2 stop-instances --instance-ids i-09a9de85bfaf851c5
```

You have setup CLI configuration in the previous step, so you should be able to run the above commands without any options.

# Destroy

Please make sure to destroy the resources when you don't need them anymore, otherwise you will be charged for the resources.

```sh
terraform destroy
```

Hope this repository helps you to setup your own Minecraft server on AWS :)

