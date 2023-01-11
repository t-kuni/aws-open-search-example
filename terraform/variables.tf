variable "project_name" {
  default = "aws_open_search_example"
}

variable "project_name_hyphen" {
  default = "aws-open-search-example"
}

variable "aws_access_key_id" {
  sensitive = true
}

variable "aws_secret_access_key" {
  sensitive = true
}

variable "aws_region" {
}

variable "open_search_master_user_name" {
  sensitive = true
}

variable "open_search_master_user_password" {
  sensitive = true
}