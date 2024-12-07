variable "ami" {
    type = string
    default = "ami-0be656e75e69af1a9"
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "availability_zone" {
    type = string
    default = "eu-central-1"
}