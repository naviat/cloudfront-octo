output "cloudfront_distribution_ids" {
  value = { for k, v in aws_cloudfront_distribution.eks_distribution : k => v.id }
}
