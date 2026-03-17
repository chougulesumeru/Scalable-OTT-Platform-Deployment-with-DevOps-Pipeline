# configure varibales for terraform infra

variable "instance_type" {
  description = "instance type"
  default     = "t2.medium"
  type        = string
}

variable "ami" {
  description = "ami id"
  default     = "ami-0198cdf7458a7a932"
  type        = string
}

variable "volume_size" {
  description = "volume-size"
  default     = 20
  type        = string
}

variable "aws_region" {
  default = "us-east-2"
  type    = string
}

variable "server_name" {
  description = "server name"
  default     = "ott-deployment-server"
  type        = string
}

variable "aws_key_name" {
  description = "key-name"
  default     = "ott-deployment"
  type        = string
}
