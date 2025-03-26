output "file_contents" {
  description = "Prints file content"
  value       = local_file.example.content
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}