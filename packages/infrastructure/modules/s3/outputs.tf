output "lambdas_bucket_arn" {
  value = aws_s3_bucket.lambdas_bucket.arn
}

output "lambda_bucket_name" {
  value = aws_s3_bucket.lambdas_bucket.id
}
