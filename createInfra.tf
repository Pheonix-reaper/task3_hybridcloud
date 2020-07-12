provider "aws" {
	profile ="Asish"
	region ="ap-south-1"
}

resource "aws_vpc" "task2_vpc" {
  cidr_block       = "192.169.0.0/16"
  instance_tenancy = "default"
   enable_dns_hostnames= "true"

  tags = {
    Name = "task2_vpc"
  }
}

resource "aws_subnet" "task2_subnet_1a" {
  vpc_id     = "${aws_vpc.task2_vpc.id}"
   availability_zone = "ap-south-1a"
   cidr_block = "192.169.1.0/24"
    map_public_ip_on_launch = "true"
  
  tags = {
    Name = "task2_subnet_1a"
  }
}

resource "aws_subnet" "task2_subnet_1b" {
  vpc_id     = "${aws_vpc.task2_vpc.id}"
   availability_zone = "ap-south-1b"
  cidr_block = "192.169.2.0/24"

  tags = {
    Name = "task2_subnet_1b"
  }
}

resource "aws_internet_gateway" "task2_gw" {
  vpc_id = "${aws_vpc.task2_vpc.id}"

  tags = {
    Name = "task2_gw"
  }
}

resource "aws_route_table" "task2_routetable" {
  vpc_id = "${aws_vpc.task2_vpc.id}"

  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.task2_gw.id}"
  }

  tags = {
    Name = "task2_routetable"
  }
}

resource "aws_route_table_association" "task2_route_1a"{
 subnet_id= aws_subnet.task2_subnet_1a.id
  route_table_id = "${aws_route_table.task2_routetable.id}"
}


resource "tls_private_key"  "mytask2key"{
	algorithm= "RSA"
}

resource  "aws_key_pair"   "generated_key"{
	key_name= "mytask2key"
	public_key= "${tls_private_key.mytask2key.public_key_openssh}"
	
	depends_on = [
		tls_private_key.mytask2key
		]
}

resource "local_file"  "store_key_value"{
	content= "${tls_private_key.mytask2key.private_key_pem}"
 	filename= "mytask2key.pem"
	
	depends_on = [
		tls_private_key.mytask2key
	]
}

resource "aws_security_group" "task2_securitygrp" {
  name        = "task2_securitygrp"
  description = "Allow TLS inbound traffic and SSH for remote login"
  vpc_id      = "${aws_vpc.task2_vpc.id}"

 ingress{
    description= "TCP from VPC"
     from_port = 3306
      to_port = 3306
      protocol= "tcp"
      cidr_blocks = ["0.0.0.0/0"]
}

 ingress{
    description = "SSH"
     from_port =22
     to_port=22
      protocol ="tcp"
       cidr_blocks = ["0.0.0.0/0"]
}
 ingress{
    description = "HTTP"
     from_port=80
      to_port=80
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "task2_securitygrp"
  }
}


resource "aws_instance"  "task2_wordpressOS"{
		ami= "ami-00116985822eb866a"
		instance_type= "t2.micro"
		key_name=  aws_key_pair.generated_key.key_name
		vpc_security_group_ids= ["${aws_security_group.task2_securitygrp.id}"]
 		subnet_id="${aws_subnet.task2_subnet_1a.id}"
tags= {
     name= "task2_wordpressos"
         }
}

resource "aws_instance"  "task2_MYSQLOS"{
		ami= "ami-08706cb5f68222d09"
		instance_type= "t2.micro"
		key_name=  aws_key_pair.generated_key.key_name
		vpc_security_group_ids= ["${aws_security_group.task2_securitygrp.id}"]
 		subnet_id="${aws_subnet.task2_subnet_1b.id}"
tags= {
     name= "task2_MYSQLOS"
         }
}

output "myos_ip" {
  value = aws_instance.task2_wordpressOS.public_ip
}provider "aws" {
	profile ="Asish"
	region ="ap-south-1"
}

resource "aws_vpc" "task2_vpc" {
  cidr_block       = "192.169.0.0/16"
  instance_tenancy = "default"
   enable_dns_hostnames= "true"

  tags = {
    Name = "task2_vpc"
  }
}

resource "aws_subnet" "task2_subnet_1a" {
  vpc_id     = "${aws_vpc.task2_vpc.id}"
   availability_zone = "ap-south-1a"
   cidr_block = "192.169.1.0/24"
    map_public_ip_on_launch = "true"
  
  tags = {
    Name = "task2_subnet_1a"
  }
}

resource "aws_subnet" "task2_subnet_1b" {
  vpc_id     = "${aws_vpc.task2_vpc.id}"
   availability_zone = "ap-south-1b"
  cidr_block = "192.169.2.0/24"

  tags = {
    Name = "task2_subnet_1b"
  }
}

resource "aws_internet_gateway" "task2_gw" {
  vpc_id = "${aws_vpc.task2_vpc.id}"

  tags = {
    Name = "task2_gw"
  }
}

resource "aws_route_table" "task2_routetable" {
  vpc_id = "${aws_vpc.task2_vpc.id}"

  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.task2_gw.id}"
  }

  tags = {
    Name = "task2_routetable"
  }
}

resource "aws_route_table_association" "task2_route_1a"{
 subnet_id= aws_subnet.task2_subnet_1a.id
  route_table_id = "${aws_route_table.task2_routetable.id}"
}


resource "tls_private_key"  "mytask2key"{
	algorithm= "RSA"
}

resource  "aws_key_pair"   "generated_key"{
	key_name= "mytask2key"
	public_key= "${tls_private_key.mytask2key.public_key_openssh}"
	
	depends_on = [
		tls_private_key.mytask2key
		]
}

resource "local_file"  "store_key_value"{
	content= "${tls_private_key.mytask2key.private_key_pem}"
 	filename= "mytask2key.pem"
	
	depends_on = [
		tls_private_key.mytask2key
	]
}

resource "aws_security_group" "task2_securitygrp" {
  name        = "task2_securitygrp"
  description = "Allow TLS inbound traffic and SSH for remote login"
  vpc_id      = "${aws_vpc.task2_vpc.id}"

 ingress{
    description= "TCP from VPC"
     from_port = 3306
      to_port = 3306
      protocol= "tcp"
      cidr_blocks = ["0.0.0.0/0"]
}

 ingress{
    description = "SSH"
     from_port =22
     to_port=22
      protocol ="tcp"
       cidr_blocks = ["0.0.0.0/0"]
}
 ingress{
    description = "HTTP"
     from_port=80
      to_port=80
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "task2_securitygrp"
  }
}


resource "aws_instance"  "task2_wordpressOS"{
		ami= "ami-00116985822eb866a"
		instance_type= "t2.micro"
		key_name=  aws_key_pair.generated_key.key_name
		vpc_security_group_ids= ["${aws_security_group.task2_securitygrp.id}"]
 		subnet_id="${aws_subnet.task2_subnet_1a.id}"
tags= {
     name= "task2_wordpressos"
         }
}

resource "aws_instance"  "task2_MYSQLOS"{
		ami= "ami-08706cb5f68222d09"
		instance_type= "t2.micro"
		key_name=  aws_key_pair.generated_key.key_name
		vpc_security_group_ids= ["${aws_security_group.task2_securitygrp.id}"]
 		subnet_id="${aws_subnet.task2_subnet_1b.id}"
tags= {
     name= "task2_MYSQLOS"
         }
}

output "myos_ip" {
  value = aws_instance.task2_wordpressOS.public_ip
}
