# Note: You should install AWC CLi and Terraform as pre-requisites
# Create a EC2-Instance : Specify the EC2-Instance details
# This is EC2-Instance creation Also adding EBS Volume
resource "aws_instance" "res1-ec2" {
    ami = "${var.ami-name}"
    instance_type = "${var.vm-type[1]}"
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
###### Crating the EBS-Volume 
resource "aws_ebs_volume" "swap-vol" {
    size = "${var.swap-vol-size}"
    availability_zone = "${aws_instance.res1-ec2.availability_zone}"
    tags = {
        name = "${var.vol-name}"
    }
}
###### Attaching the EBS-SWAP Volume to EC2-Instance
resource "aws_volume_attachment" "swap-vol-attach" {
    device_name = "/dev/xvdi"
    volume_id = "${aws_ebs_volume.swap-vol.id}"
    instance_id =  "${aws_instance.res1-ec2.id}"
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("./scripts/sktech-kg.pem")
        host = "${aws_instance.res1-ec2.public_ip}"
    }
    provisioner "remote-exec" {
        inline = [
            "uname -a",
            "sudo useradd kkumar",
        ]
    }
}