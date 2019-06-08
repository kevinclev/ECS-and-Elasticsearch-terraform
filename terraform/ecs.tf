resource "aws_ecs_cluster" "main" {
  name = "webapp-cluster"
}

data "template_file" "web-app-container-definitions" {
  template = "${file("terraform/files/web-app-container-definitions.json.tpl")}"

  vars = {
    app_image      = "${var.app_image}"
    fargate_cpu    = "${var.fargate_cpu}"
    fargate_memory = "${var.fargate_memory}"
    aws_region     = "${var.aws_region}"
    app_port       = "${var.app_port}"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "web-app-task"
  execution_role_arn       = "${var.ecs_task_execution_role}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"
  container_definitions    = "${data.template_file.web-app-container-definitions.rendered}"
}

resource "aws_ecs_service" "main" {
  name            = "web-app-service"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "${var.app_count}"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = ["${aws_security_group.external.id}","${aws_security_group.internal.id}"]
    subnets          = ["${element(var.subnet_ids, 0)}","${element(var.subnet_ids, 1)}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.webapp.id}"
    container_name   = "web-app"
    container_port   = "${var.app_port}"
  }

  depends_on = [
    "aws_alb_listener.front_end",
  ]
}