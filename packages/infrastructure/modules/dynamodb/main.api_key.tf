resource "aws_dynamodb_table" "api_key_table" {
  name         = format("api_key_table_%s", var.random_name)
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

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

  global_secondary_index {
    name               = "KeyTypeIndex"
    hash_key           = "KeyType"
    range_key          = "UID"
    projection_type    = "INCLUDE"
    non_key_attributes = ["ApiKey", "Timestamp"]
  }

  global_secondary_index {
    name               = "UIDIndex"
    hash_key           = "UID"
    range_key          = "KeyType"
    projection_type    = "INCLUDE"
    non_key_attributes = ["ApiKey", "Timestamp"]
  }

  global_secondary_index {
    name               = "APIKeyIndex"
    hash_key           = "ApiKey"
    range_key          = "UID"
    projection_type    = "INCLUDE"
    non_key_attributes = ["KeyType", "Timestamp"]
  }
}
