module "event_rule" {
  source                         = "../../../modules/cloudwatch"
  count_event_rule               = "enabled"
  name                           = "captain-earning-service"
  event_rule_descript            = "captain_earning service event publish through terraform"
  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ]
}
PATTERN
  event_rule_name                = "captain_earning_service"
  target_id                      = "captain_earning_event_target"
  target_arn                     = "arn:aws:sns:eu-west-1:848569320300:qa-pager"
}

module "captain-earning_dashboard" {
  source                         = "../../../modules/cloudwatch"
  count_dashboard                = "enabled"
  dashboard_name                 = "captain_earning_service_dashboard"
  dashboard_body                 =  <<EOF
  {
     "widgets": [
         {
            "type":"metric",
            "x":0,
            "y":0,
            "width":12,
            "height":6,
            "properties":{
               "metrics":[
                  [
                     "AWS/ElasticBeanstalk",
                     "EnvironmentHealth",
                     "EnvironmentName",
                     "ping-realtime-masstrans-test"
                  ]
               ],
               "period":300,
               "stat":"Average",
               "region":"eu-west-1",
               "title":"Environment Health"
            }
         },
         {
            "type":"metric",
            "x":0,
            "y":0,
            "width":12,
            "height":6,
            "properties":{
               "metrics":[
                  [
                     "AWS/ElasticBeanstalk",
                     "ApplicationRequestsTotal",
                     "EnvironmentName",
                     "ping-realtime-masstrans-test"
                  ]
               ],
               "period":300,
               "stat":"Average",
               "region":"eu-west-1",
               "title":"Application total request"
            }
         }
     ]
   }
   EOF
}

module "log_group" {
  source                     = "../../../modules/cloudwatch"
  count_log              = "enabled"
  name                   = "Captain_earning_service_log_group"
  tags {
    Environment = "production"
    Application = "Captain_earning_service_log_group"
  }
}

module "ebs_alarm" {
  source                     = "../../../modules/cloudwatch"
  count_metric_alert        = "disabled"
  name                      = "captain_earning_service_health_alarm"
  comparison_operator       = "${var.comparison_operator}"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "EnvironmentHealth"
  namespace                 = "AWS/ElasticBeanstalk"
  period                    = "${var.period}"
  statistic                 = "Average"
  threshold                 = "${var.threshold}"
  alarm_description         = "Environment health is greater than normal threashold "
  ok_actions                = "arn:aws:sns:eu-west-1:848569320300:qa-pager"
  alarm_actions             = "${var.alarm_actions}"
  actions_enabled           = "true"
}