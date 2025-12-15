module "network" {
  source     = "./_modules/network"
  aws_region = var.aws_region
  app_name   = var.app_name
  app_port   = var.app_port
}

module "iam" {
  source   = "./_modules/iam"
  app_name = var.app_name
}

module "ecs" {
  source             = "./_modules/ecs"
  aws_region         = var.aws_region
  app_name           = var.app_name
  app_port           = var.app_port
  fargate_cpu        = var.fargate_cpu
  fargate_memory     = var.fargate_memory
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
  subnet_ids         = module.network.subnet_ids
  security_group_id  = module.network.security_group_id
}

module "monitoring" {
  source       = "./_modules/monitoring"
  app_name     = var.app_name
  alert_email  = var.alert_email
  cluster_name = module.ecs.cluster_name
  service_name = module.ecs.service_name
}
