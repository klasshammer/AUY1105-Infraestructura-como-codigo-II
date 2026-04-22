variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
 // default     = "t3.micro"


}

variable "sg_cidr_blocks" {
    description = "Block de Ip de acceso en el SG"
    type = string
    default = "0.0.0.0/0"
}
