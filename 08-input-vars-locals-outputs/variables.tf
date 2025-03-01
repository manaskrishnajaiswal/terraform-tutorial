# variable "aws_region" {
#   type = string
# }

variable "aws_ec2_instance_type" {
  type = string
  # default     = "t2.micro"
  description = "cpu and memory combination of ec2 server."
  validation {
    # condition = var.aws_ec2_instance_type == "t2.micro" || var.aws_ec2_instance_type == "t3.micro"
    condition     = contains(["t2.micro", "t3.micro"], var.aws_ec2_instance_type)
    error_message = "value"
  }
}

# variable "aws_volume_size" {
#   type = number
#   description = "size of volume attached to ec2 server."
# }

# variable "aws_volume_type" {
#   type = string
#   description = "type of volume attached to ec2 server."
# }

variable "aws_ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  # default = {
  #   size = 10
  #   type = "gp3"
  # }
  description = "size and type values of volume config"
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}