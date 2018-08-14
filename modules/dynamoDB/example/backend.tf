terraform {
 backend "s3" {
   bucket = "tempgoterratest"
   key    = "dynamoDB/terraform.tfstate"
   region = "eu-west-1"
   workspace_key_prefix = "statefiles"
 }
}