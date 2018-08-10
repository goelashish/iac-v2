module "iac-test-as-db" {
  source                 = "../../../modules/dynamodb"
  count                  = "1"
  name                   = "iac-test-asg-db"
  write_capacity         = "${var.write_capacity}"
  read_capacity          = "${var.read_capacity}"
  read_autoscaling       = "disabled"
  write_autoscaling      = "disabled"
  read_max_capacity      = "${var.read_max_capacity}"
  read_min_capacity      = "${var.read_min_capacity}"
  write_max_capacity     = "${var.write_max_capacity}"
  write_min_capacity     = "${var.write_max_capacity}"
  write_target_value     = 50
  read_target_value      = 50
}



module "iac-test" {
  source                 = "../../../modules/dynamodb"
  count                  = "1"
  name                   = "iac-test"
  write_capacity         = "${var.write_capacity}"
  read_capacity          = "${var.read_capacity}"
  read_autoscaling       = "${terraform.workspace == "prod" ? var.enabled : var.disabled }"
  write_autoscaling      = "${terraform.workspace == "prod" ? var.enabled : var.disabled }"
  read_max_capacity      = "${var.read_max_capacity}"
  read_min_capacity      = "${var.read_min_capacity}"
  write_max_capacity     = "${var.write_max_capacity}"
  write_min_capacity     = "${var.write_max_capacity}"
  write_target_value     = 50
  read_target_value      = 50
}