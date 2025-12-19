resource "aws_cloudfront_origin_access_control" "frontend"{
    name = "frontend-oac"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}

resource "aws_s3_bucket_policy" "frontend"{
    bucket = aws_s3_bucket.frontend.id

    policy = jsonencode(
        {
            Version = "2012-10-17"
            Statement = [
                {
                    Effect = "Allow"
                    Principal = {
                        Service = "cloudfront.amazonaws.com"
                    }
                    Action = "s3:GetObject"
                    Resource = "${aws_s3_bucket.frontend.arn}/*"
                    Condition = {
                        StringEquals = {
                            "AWS:SourceArn"= aws_cloudfront_distribution.frontend.arn
                        }
                    }
                }
            ]
        }
    )
}