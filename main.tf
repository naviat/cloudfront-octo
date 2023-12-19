provider "aws" {
  region = "us-west-2"
}

resource "aws_cloudfront_distribution" "eks_distribution" {
  for_each = var.eks_clusters

  origin {
    domain_name = each.value.domain_name
    origin_id   = each.key
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = each.key

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = each.value.locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
