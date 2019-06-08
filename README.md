# ECS-and-Elasticsearch-terraform

## About 

This Terraform config goes through and sets up a simple webapp with ECS along with an AWS ElasticSearch instance.

## Requirements

* AWS account with a VPC and subnets

* Terraform

## Usage

There are a few varibles that you will need to supply in vars.tf

```
variable "ecs_task_execution_role" {
  description = "Role arn for the ecsTaskExecutionRole"
  default     = "<arn for ecsTaskExecutionRole>"
}

variable "vpc_id" {
  description = "VPC to deploy to"
  default     = "<vpc-id>"
}

variable "subnet_ids" {
  type        = list
  default     = ["subnet ids"] # need at least two for the alb
}
```

To launch the ECS and ElasticSearch clusters

```
terraform apply terraform/
```