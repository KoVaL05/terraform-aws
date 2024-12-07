locals {
  resolvers = {
    "getApiKey" = {
      path = "../resolvers/get_api_key.js"
      kind = "UNIT"
      type = "Query"
      data_source = "api_key_table"
    }
    "getAllApiKeys" = {
      path = "../resolvers/get_api_key.js"
      kind = "UNIT"
      type = "Query"
      data_source = "api_key_table"
    }
  }
}