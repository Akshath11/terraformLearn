variable "region" {
    default     = "ap-south-1"
}

variable "cidr_block" {
    default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
    type        = list
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidr_blocks" {
    type        = list
    default     = ["10.0.3.0/24", "10.0.4.0/24"]  
}   

variable "ni_private-ip" {
    type        = list
    default     = ["10.0.3.1"]
}

variable "availability_zones" {
    type        = list
    default     = ["ap-south-1a", "ap-south-1b"]
}

variable "name"{
    type        = list
    default     = ["ec2-1" , "ec2-2"]
}

variable "instance_type" {
    default = "t2.micro"
}

variable "instance_type" {
  default = "ami-0f8ca728008ff5af4"
}

variable "key_name" {
    default = "deployer-key"
}


variable "architecture" {
    type        = list
    default     = ["x86_64"] 
  
}