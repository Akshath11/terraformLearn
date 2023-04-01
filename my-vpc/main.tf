terraform {
    required_version = ">= 1.4"
}

provider "aws" {
    region          = var.region
}

module "vpc" {
    source          = "./vpc-defination"
    cidr_block      = var.cidr_block
    private_subnet_cidr_blocks  = var.private_subnet_cidr_blocks
    public_subnet_cidr_blocks   = var.public_subnet_cidr_blocks
    availability_zones          = var.availability_zones
}

# module "vpc" {
#     source          = "./vpc-defination"
#     cidr_block      = 192.168.0.0/20
#     private_subnet_cidr_blocks  = []
#     public_subnet_cidr_blocks   = var.public_subnet_cidr_blocks
#     availability_zones          = var.availability_zones
# }