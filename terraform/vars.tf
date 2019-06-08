variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "httpd:2.4"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "ecs_task_execution_role" {
  description = "Role arn for the ecsTaskExecutionRole"
  default     = "<arn for ecsTaskExecutionRole>"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "vpc_id" {
  description = "VPC to deploy to"
  default     = "<vpc-id>"
}

variable "subnet_ids" {
  type        = list
  default     = ["subnet ids"] # need at least two for the alb
}

variable "es_domain" {
  description = "ElasticSearch domain name"
  default = "webapp-es"
}