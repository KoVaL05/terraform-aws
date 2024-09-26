resource "aws_dynamodb_table" "api_key_table" {
  name = format("api_key_table_%s")
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "ID"

  stream_enabled = true

  attribute {
    name = "ID"
    type = "S"
  }

  attribute {
    name = "UID"
    type = "S"
  }

  attribute {
    name = "KeyType"
    type = "S"
  }

  attribute {
    name = "ApiKey"
    type = "S"
  }

    ttl {
    attribute_name = "Timestamp"
    }

   global_secondary_index {
    name               = "KeyTypeIndex"
    hash_key           = "KeyType"
    range_key          = "UID"
    projection_type    = "INCLUDE"
    non_key_attributes = ["ApiKey","Timestamp"]
  }

  global_secondary_index {
    name               = "UIDIndex"
    hash_key           = "UID"
    range_key          = "KeyType"
    projection_type    = "INCLUDE"
    non_key_attributes = ["ApiKey","Timestamp"]
  }
}