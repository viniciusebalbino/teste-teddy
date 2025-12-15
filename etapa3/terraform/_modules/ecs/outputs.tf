output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "service_name" {
  value = aws_ecs_service.main.name
}

output "repo_name" {
  value = aws_ecr_repository.repo.name
}
