resource "aws_secretsmanager_secret" "aethera_app_secret" {
  name = "aethera_flutter_app"
}

resource "aws_secretsmanager_secret_version" "aethera_secret_value" {
  secret_id     = aws_secretsmanager_secret.aethera_app_secret.id
  secret_string = jsonencode(var.aethera_app_secret)
}