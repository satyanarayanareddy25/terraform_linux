
variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1" # Update to your preferred region
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" # Update to your preferred instance type
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = "satya"
}
