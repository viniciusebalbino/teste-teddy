variable "app_name" {}
variable "app_port" {}
variable "aws_region" {}
variable "fargate_cpu" {}
variable "fargate_memory" {}
variable "execution_role_arn" {}
variable "task_role_arn" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
