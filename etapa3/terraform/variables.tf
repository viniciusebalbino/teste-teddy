variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "teddy-app"
}

variable "app_port" {
  default = 80
}

variable "fargate_cpu" {
  default = 256
}

variable "fargate_memory" {
  default = 512
}

variable "alert_email" {
  default = "vinicius.balbino@teddy.com"
}
