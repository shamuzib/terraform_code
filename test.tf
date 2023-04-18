# Define variables
variable "db_cluster_identifier" {
  description = "DB cluster identifier"
}

variable "db_instance_identifier" {
  description = "DB instance identifier"
}

variable "metric_thresholds" {
  description = "Metric thresholds"
  type = map
  default = {
    "ACUUtilization" = {
      "warning" = 75
      "critical" = 90
    }
    "AuroraReplicaLag" = {
      "warning" = 5000
      "critical" = 25000
    }
    "CPUUtilization" = {
      "warning" = 75
      "critical" = 90
    }
    "ServerlessDBCapacity" = {
      "warning" = 75
      "critical" = 90
    }
  }
}

# Create CloudWatch alarms for RDS metrics
resource "aws_cloudwatch_metric_alarm" "rds_metrics" {
  for_each = var.metric_thresholds

  alarm_name          = "${each.key} alarm for ${var.db_cluster_identifier} - ${var.db_instance_identifier}"
  alarm_description   = "Alarm for RDS metric ${each.key} for DB cluster ${var.db_cluster_identifier} - DB instance ${var.db_instance_identifier}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = each.key
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"

  dimensions = {
    DBClusterIdentifier = var.db_cluster_identifier
    DBInstanceIdentifier = var.db_instance_identifier
  }

  threshold_metric_id = "1"
  threshold_unit      = "Seconds"

  # Warning threshold
  threshold_warning = var.metric_thresholds[each.key]["warning"]

  # Critical threshold
  threshold_critical = var.metric_thresholds[each.key]["critical"]

  actions_enabled = false
  ok_actions      = []
  alarm_actions   = []
  insufficient_data_actions = []
}
