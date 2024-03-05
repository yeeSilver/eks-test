data "http" "AWSLoadBalancerController_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.cluster_name
}