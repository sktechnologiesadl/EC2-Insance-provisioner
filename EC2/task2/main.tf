# Note: You should install AWC CLi and Terraform as pre-requisites
# Create a EC2-Instance : Specify the EC2-Instance details
# This is simple EC2-Instance creation 
# Everything is variabled like instance_name, instance_type etc but calling from vars.tfvars file
 
resource "aws_instance" "res1-ec2" {
    ami = "${var.ami-name}"
    instance_type = "${var.vm-type[1]}"
    tags = {
        name = "${var.vm-name}"
    }
    key_name = "${var.pemfile-name}"
    vpc_security_group_ids = ["${var.secgp-name}"]
}