resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.es_domain}"
  elasticsearch_version = "6.7"

  cluster_config {
    instance_type            = "t2.small.elasticsearch"
    instance_count           = 1
    dedicated_master_enabled = false
  }

  vpc_options {
    subnet_ids         = ["${element(var.subnet_ids, 0)}"]
    security_group_ids = ["${aws_security_group.internal.id}"]
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  access_policies = <<CONFIG
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "es:*",
        "Principal": "*",
        "Effect": "Allow",
        "Resource": "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.es_domain}/*"
      }
    ]
  }
  CONFIG

  node_to_node_encryption {
    enabled = true
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "${var.es_domain}"
  }
}
