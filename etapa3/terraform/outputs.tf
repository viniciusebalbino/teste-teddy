output "ecr_repository" {
  value = module.ecs.repo_name
}

output "ecs_cluster" {
  value = module.ecs.cluster_name
}

output "ecs_service" {
  value = module.ecs.service_name
}
