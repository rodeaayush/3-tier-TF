variable "vpc_id" {
  type = string
}

variable "SG" {
  type = list(string)
}
variable "private-tom" {
  type = string
}
variable "private-db" {
  type = string
}
variable "public-nginx" {
  type = string
}