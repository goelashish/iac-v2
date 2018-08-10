terraform {
 backend "s3" {
   bucket = "tempgoterratest"
   key    = "dynamodb/terraform.tfstate"
   region = "eu-west-1"
   workspace_key_prefix = "statefiles"
 }
}