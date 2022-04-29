# VPC CIDR Block
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

variable "environment" {
  description = "environment"
  type = string 
  default = "stage"
}

# subnet1
variable "subnet1_cidr" {
  description = "aws_subnet"
  type = string 
  default = "10.0.0.0/24"
}

# pvtsubnet1
variable "pvtsubnet1_cidr" {
  description = "aws_private_subnet"
  type = string 
  default = "10.0.3.0/24"
}


# availability zones
variable "availability_zones" {
  description = "availability zones"
  type = string 
  default = "us-east-1a"
}

