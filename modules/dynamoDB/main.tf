resource "aws_dynamodb_table" "dynamodb-table" {
  count                  = "${var.count}"
  name                   = "${terraform.workspace}-${var.name}"
  hash_key               = "${var.hash_key}"
  range_key              = "${var.range_key}"
  write_capacity         = "${var.write_capacity}"
  read_capacity          = "${var.read_capacity}"
  stream_enabled         = "${var.stream == "enabled" ? 1 : 0}"
  stream_view_type       = "${var.stream_view_type}"
  attribute              = "${var.attribute}"
  global_secondary_index = "${var.global_secondary_index}"
  local_secondary_index  = "${var.local_secondary_index}"
  ttl                    = "${var.ttl}"
  tags                   = "${var.tags}"

  lifecycle {
    ignore_changes = [
      "read_capacity",
      "write_capacity",
      "global_secondary_index",
    ]
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  count              = "${var.read_autoscaling == "enabled" ? 1 : 0}"
  max_capacity       = "${var.read_max_capacity}"
  min_capacity       = "${var.read_min_capacity}"
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table.id}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  count              = "${var.read_autoscaling == "enabled" ? 1 : 0}"
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_table_read_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_table_read_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = "${var.read_target_value}"
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count              = "${var.write_autoscaling == "enabled" ? 1 : 0}"
  max_capacity       = "${var.write_max_capacity}"
  min_capacity       = "${var.write_min_capacity}"
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table.id}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
  count              = "${var.write_autoscaling == "enabled" ? 1 : 0}"
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_table_write_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_table_write_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_table_write_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = "${var.write_target_value}"
  }
}