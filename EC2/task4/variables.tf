variable "ami-name"{
    description = "This is AMI name"
    default = "ami-0d951b011aa0b2c19"
}
variable "vm-type"{
    description = "This is VM Type"
    type = list
    default = ["t2.nano", "t2.micro", "t2.medium"]
}
variable "vm-name" {
    description = "This is VM Name"
    default = "sktech-vm1"
}
variable "pemfile-name" {
    description = "This is PEM file name"
    default = "sktech-kg"
}
variable "secgp-name"{
    description = "This is SecurityGroup name"
    default = "sg-04aca16ea4116af97"
}
variable "swap-vol-size" {
    description = "This is SWAP vol size"
    default = "4"
}
variable "vol-name"{
    description = "This is Volume name"
    default = "swap-vol"
}

