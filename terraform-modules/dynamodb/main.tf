# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.table_name
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
  read_capacity = 10
  write_capacity = 10
}