variable "default_block" {
  default = ["0.0.0.0/0"]
}

variable "ingress_block" {

  default = ["187.180.61.162/32"]
}

# variable "vpc_id" {
#   type    = string
#   default = "vpc-09c39f9d1deff1985"
# }


# variable "subnet_id" {
#   type    = string
#   default = "subnet-0768d1198457199a6"
# }

variable "instance_type" {
  default = "t2.micro"
  type    = string

}

variable "ec2_ami" {
  default = "ami-00c8f89961198e9a5"
  type    = string

}


