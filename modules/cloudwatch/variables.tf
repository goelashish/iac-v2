	variable "name" {
description  = "(Required) The descriptive name for the alarm. This name must be unique within the user's AWS account"
default = ""
}

variable "count_metric_alert" {
description = "(Required) This will enable metric alert module module"
default = 0
}

variable "comparison_operator" {
description = "- (Required) The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
type = "map"
default = {
GreaterThanOrEqualToThreshold = "GreaterThanOrEqualToThreshold"

}
}

variable "evaluation_periods" {
description = "(Required) The number of periods over which data is compared to the specified threshold."
default = {}
}

variable "metric_name" {
description = "(Required) The name for the alarm's associated metric. For reference: https://goo.gl/u3VeRN"
default = ""
}

variable "namespace" {
description = "(Required) The namespace for the alarm's associated metric. See docs for the list of namespaces. For reference: https://goo.gl/u3VeRN"
default = ""
}

variable "period" {
description = "(Required) The period in seconds over which the specified statistic is applied."
default = {}
}

variable "statistic" {
description = "(Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
default = ""
}

variable "threshold" {
description = "(Required) The value against which the specified statistic is compared."
default = {}
}

variable "alarm_description" {
description = "(Optional) The description for the alarm."
default = ""
}

variable "ok_actions" {
description = "(Optional) The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
default = ""
}

variable "alarm_actions" {
description = " (Optional) The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
default = ["arn:aws:sns:eu-west-1:848569320300:qa-pager"]
}

variable "actions_enabled" {
description = "(Optional) Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true."
default = ""
}

variable "unit" {
description = "(Optional) The unit for the alarm's associated metric."
default = {}
}

variable "treat_missing_data" {
description = "(Optional) Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing."
default = ""
}

variable "insufficient_data_actions" {
description = "(Optional) The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
default = ""
}




####################################################################################
##############################  Dashboard variable #################################
####################################################################################

variable "dashboard_name" {
description = "(Required) The name of the dashboard. the name provided in this varialble, aws will create dashbaord agisnat this dashboard"
default = ""
}

variable "count_dashboard" {
description = "(Required) This will enable dashboard module"
default = 0

}

variable "dashboard_body" {
description = <<DESCRIPTION
dashboard body will be like below example
dashboard_body          = <<EOF
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
                   "AWS/EC2", for namespace you can refer this link https://goo.gl/wYebnt
                   "CPUUtilization", for metric you can refer this link : https://goo.gl/u3VeRN
                   "InstanceId",
                   "i-012345"
                ]
             ],
             "period":300,
             "stat":"Average",
             "region":"us-east-1",
             "title":"EC2 Instance CPU"
          }
       },
       {
          "type":"text",
          "x":0,
          "y":7,
          "width":3,
          "height":3,
          "properties":{
             "markdown":"Hello world"
          }
       }
   ]
 }
 EOF
}

dashboard_body - (Required) The detailed information about the dashboard, including what widgets are included and their location on the dashboard. You can read more about the body structure in the
documentation{https://goo.gl/vNBZGM}.
DESCRIPTION
default = ""
}

####################################################################################
############################## Cloud event_rule /target & log group #################################
####################################################################################

variable "count_event_rule" {
description = "(Required) This will enable event_rule module"
default = 0
}

variable "count_log" {
description = "(Required) This will enable log module"
default = 0
}

variable "event_rule_descript" {
description = "(Optional) The description of the rule."
default = ""
}

variable "target_id" {
description = "(required) target ID will be generated by terraform if hadnt provide in target. but if you are using event rule console you need to add target ID on existing resource"
default = ""
}

variable "sns_topic_value" {
description = "(required) sns topic value is the name of sns topic of aws resource"
default = ""
}

variable "log_group_name" {
description = "(Optional, Forces new resource) The name of the log group. If omitted, Terraform will assign a random, unique name."
default = ""
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "A mapping of tags to assign to the resource."
}
variable "target_arn" {
default = ""
}

variable "event_pattern"{
default = ""
}
variable "event_rule_name"
{
default = ""
}