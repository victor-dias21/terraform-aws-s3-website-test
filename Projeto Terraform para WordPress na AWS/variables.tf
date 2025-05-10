variable "vpc_id" {
  description = "ID da VPC onde a instância será criada"
  type        = string
}

variable "subnet_id" {
  description = "ID da Subnet onde a instância será criada"
  type        = string
}

variable "ami_id" {
  description = "AMI ID para criar a instância EC2"
  type        = string
}