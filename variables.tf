variable "eks_clusters" {
  description = "Mapping list objects EKS clusters"
  type = map(object({
    domain_name : string
    locations    : list(string)
  }))
}
