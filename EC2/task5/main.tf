# Note: You should install AWC CLi and Terraform as pre-requisites
# Create a EC2-Instance : Specify the EC2-Instance details
# Crating EC2-Instance with 10Gib Volume 
# Creating the SWAP and enable with 4GB
resource "aws_instance" "res1-ec2" {
    ami = "${var.ami-name}"
    instance_type = "${var.vm-type[1]}"
    tags = {
        name = "${var.vm-name}"
    }
    key_name = "${var.pemfile-name}"
    vpc_security_group_ids = ["${var.secgp-name}"]
    root_block_device {
        volume_type = "gp2"
        volume_size = 10
        tags = {
            name = "root-vol"
        }
    }
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
            "sudo sh /home/ec2-user/Rlogin/rlogin.sh",
            "sudo dd if=/dev/zero of=/mnt/myswapfile  bs=4096 count=1048576",
            "sudo chmod 600 /mnt/myswapfile",
            "sudo mkswap /mnt/myswapfile",
            "sudo swapon /mnt/myswapfile",
            "free -h"
        ]
    }
}