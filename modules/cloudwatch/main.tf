resource "aws_cloudwatch_metric_alarm" "metric_alert" {
  count                     = "${var.count_metric_alert == "enabled" ? 1 : 0}"
  alarm_name                = "${terraform.workspace}-${var.name}"
  comparison_operator       = "${var.comparison_operator}"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "${var.metric_name}"
  namespace                 = "${var.namespace}"
  period                    = "${var.period}"
  statistic                 = "${var.statistic}"
  threshold                 = "${var.threshold}"
  alarm_description         = "${var.alarm_description}"
  ok_actions                = "${var.ok_actions}"
  alarm_actions             = "${var.alarm_actions}"
  actions_enabled           = "${var.actions_enabled}"
  unit                      = "${var.unit}"
  treat_missing_data        = "${var.treat_missing_data}"
  insufficient_data_actions = "${var.insufficient_data_actions}"
}

resource "aws_cloudwatch_dashboard" "dashboard_main" {
   count                   = "${var.count_dashboard == "enabled" ? 1 : 0}"
   dashboard_name          = "${var.dashboard_name}"
   dashboard_body          = "${var.dashboard_body}"
}

resource "aws_cloudwatch_event_rule" "console" {
  count                  = "${var.count_event_rule == "enabled" ? 1 : 0}"
  name                   = "${terraform.workspace}-${var.event_rule_name}"
  description            = "${var.event_rule_descript}"
  event_pattern          = "${var.event_pattern}"
  }
resource "aws_cloudwatch_event_target" "sns" {
  count                  = "${var.count_event_rule == "enabled" ? 1 : 0}"
  rule                    = "${terraform.workspace}-${var.event_rule_name}"
  target_id               = "${var.target_id}"
  arn                     = "${var.target_arn}"
  depends_on              = ["aws_cloudwatch_event_rule.console"]
}

resource "aws_cloudwatch_log_group" "log_group" {
  count              = "${var.count_log == "enabled" ? 1 : 0}"
  name                   = "${terraform.workspace}-${var.log_group_name}"
  tags                   = "${var.tags}"
}