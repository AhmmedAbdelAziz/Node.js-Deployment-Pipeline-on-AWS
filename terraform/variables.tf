variable "region" {
  description = "AWS region"
  default     = "eu-west-3"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_1" {
  description = "CIDR block for the first subnet"
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_2" {
  description = "CIDR block for the second subnet"
  default     = "10.0.2.0/24"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-087728991e8b7b6a9"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for the EC2 instances"
  default     = "nodejs-app-key"
}

variable "public_key_path" {
  description = "Path to the public key file"
  default     = "/opt/id_rsa.pub"
}
