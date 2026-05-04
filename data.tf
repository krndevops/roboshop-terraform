data "aws_eks_cluster" "main" {
  name = aws_eks_cluster.main.name

  depends_on = [
    aws_eks_cluster.main
  ]
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name

  depends_on = [
    aws_eks_cluster.main
  ]
}