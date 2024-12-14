output "s3_bucket_id" {
  value       = aws_s3_bucket.static_bucket.id
  description = "The S3 bucket ID"
}

output "s3_bucket_bucket_prefix" {
  value       = aws_s3_bucket.static_bucket.bucket_prefix
  description = "The S3 bucket prefix"
}

output "s3_bucket_bucket_domain_name" {
  value       = aws_s3_bucket.static_bucket.bucket_domain_name
  description = "The S3 bucket domain name"
}

output "s3_bucket_bucket" {
  value       = aws_s3_bucket.static_bucket.bucket
  description = "The S3 bucket"
}

output "route53_record_alias" {
  value       = aws_route53_record.www.alias
  description = "The route 53 record alias"
}

output "route53_record_id" {
  value       = aws_route53_record.www.id
  description = "The route 53 record id"
}

output "route53_record_name" {
  value       = aws_route53_record.www.name
  description = "The route 53 record name"
}