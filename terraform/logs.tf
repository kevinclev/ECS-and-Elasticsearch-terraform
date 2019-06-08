resource "aws_cloudwatch_log_group" "webapp_log_group" {
  name              = "/ecs/web-app"
  retention_in_days = 30

  tags = {
    Name = "webapp-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "webapp_log_stream" {
  name           = "webapp-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.webapp_log_group.name}"
}