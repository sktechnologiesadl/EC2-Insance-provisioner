# Note: You should install AWC CLi and Terraform as pre-requisites
# Create a EC2-Instance : Specify the EC2-Instance details
# This is EC2-Instance creation and Performing steps which we can login without pem file 
# git repo location "https://github.com/sktechnologiesadl/Rlogin.git"
# Everything is variabled like instance_name, instance_type etc
# It will show Public IP you can login through ec2-user {default user} - Password you can check from the git repo
resource "aws_instance" "res1-ec2" {
    ami = "${var.ami-name}"
    instance_type = "${var.vm-type[0]}"
    tags = {
        name = "${var.vm-name}"
    }
    key_name = "${var.pemfile-name}"
    vpc_security_group_ids = ["${var.secgp-name}"]
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("./scripts/sktech-kg.pem")
        host = "${aws_instance.res1-ec2.public_ip}"
    }
    provisioner "remote-exec" {
        inline = [
            "uname -r",
            "sudo useradd sktech",
            "sudo yum install git -y",
            "git clone https://github.com/sktechnologiesadl/Rlogin.git",
            "cd Rlogin",
            "sudo chmod u+x /home/ec2-user/Rlogin/rlogin.sh",
            "sudo sh /home/ec2-user/Rlogin/rlogin.sh"
        ]
    }
}