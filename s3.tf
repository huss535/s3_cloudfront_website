resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "cloudfronttutorial6768"
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.static_website_bucket.bucket
  key          = "index.html"
  source       = "./website_files/index.html"
  content_type = "text/html" # Set Content-Type to text/html
  etag         = filemd5("./website_files/index.html")
}

resource "aws_s3_bucket_object" "css" {
  bucket       = aws_s3_bucket.static_website_bucket.bucket
  key          = "index.css"
  source       = "./website_files/index.css"
  content_type = "text/css" # Set Content-Type to text/css
  etag         = filemd5("./website_files/index.css")
}


resource "null_resource" "sync_assets" {
  provisioner "local-exec" {
    command = "aws s3 sync ./website_files/assets s3://${aws_s3_bucket.static_website_bucket.bucket}/assets"
  }
}

data "aws_iam_policy_document" "cloudfront_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static_website_bucket.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.static_website_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_policy.json
}


