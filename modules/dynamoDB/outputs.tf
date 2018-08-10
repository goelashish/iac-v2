output "name" {
value = "${join(",", aws_dynamodb_table.dynamodb-table.*.name)}"
}
output "stream_arn" {
 value = "${join(",", aws_dynamodb_table.dynamodb-table.*.stream_arn)}"
}