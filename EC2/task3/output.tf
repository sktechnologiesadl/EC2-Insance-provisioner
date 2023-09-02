output "public_ip"{
   value = "${aws_instance.res1-ec2.public_ip}"
}