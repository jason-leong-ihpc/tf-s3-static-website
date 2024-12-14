resource "aws_s3_bucket" "static_bucket" {
  bucket        = "${var.name_prefix}.sctp-sandbox.com"
  force_destroy = true
}


resource "aws_s3_bucket_public_access_block" "enable_public_access" {
  bucket = aws_s3_bucket.static_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket     = aws_s3_bucket.static_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.enable_public_access]
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Principal" : "*",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : ["${aws_s3_bucket.static_bucket.arn}/*"]
      }
    ]
  })
}


resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_bucket.id
  index_document {
    suffix = "index.html"
  }

  # error_document {
  #   key = "error.html"
  # }

  # routing_rule {
  #   condition {
  #     key_prefix_equals = "docs/"
  #   }
  #   redirect {
  #     replace_key_prefix_with = "documents/"
  #   }
  # }  
}


data "aws_route53_zone" "sctp_zone" {
  name = "sctp-sandbox.com"
}


resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.sctp_zone.zone_id
  name    = var.name_prefix # Bucket prefix before sctp-sandbox.com
  type    = "A"


  alias {
    name                   = aws_s3_bucket_website_configuration.website.website_domain
    zone_id                = aws_s3_bucket.static_bucket.hosted_zone_id
    evaluate_target_health = true
  }
}
