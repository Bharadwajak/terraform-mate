provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  enable_nat_gateway     = false
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name   = "ssh_security_group"
  vpc_id = "${module.vpc.vpc_id}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "vpc_work_node" {
  ami           = "ami-00e17d1165b9dd3ec"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  subnet_id = "${element(module.vpc.public_subnets,0 )}"
  vpc_security_group_ids = ["${module.vpc.default_security_group_id}","${module.ssh_security_group.this_security_group_id}"]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
