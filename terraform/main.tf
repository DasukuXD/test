resource "aws_vpc" "vnet" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "snet" {
  vpc_id            = aws_vpc.vnet.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = var.availability_zone
}

resource "aws_instance" "ec2" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  subnet_id         = aws_subnet.snet.id
}

resource "aws_network_interface" "nic" {
  subnet_id  = aws_subnet.snet.id
  private_ip = "10.0.10.250"
  attachment {
    instance     = aws_instance.ec2.id
    device_index = 1
  }
}

resource "aws_eip" "this" {
  instance          = aws_instance.ec2.id
  network_interface = aws_network_interface.nic.id
}

resource "aws_ebs_volume" "volume" {
  availability_zone = var.availability_zone
  size              = 50
}

resource "aws_volume_attachment" "attach" {
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.ec2.id
  device_name = "/dev/sdc"
}