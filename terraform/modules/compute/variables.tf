variable "admin1_ssh_key_name" {
  type = string
}

variable "admin1_ssh_key_path" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "volume_size" {
  description = "Size of the root volume in gb"
  type        = number
}

variable "volume_type" {
  description = "Type of the root volume"
  type        = string
}

variable "instance_name" {
  type = string
}
