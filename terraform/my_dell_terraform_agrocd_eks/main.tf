data "aws_eks_cluster" "this" {
   name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "this" {
   name = var.eks_cluster_name
} 

provider "helm" {
   kubernetes {
      host                   = data.aws_eks_cluster.this.endpoint
      token                  = data.aws_eks_cluster.auth.this.token
      cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
   }
}


resource "helm_release" "argocd" {
   name                      = "argocd"
   repository                = "https://argoproj.github.io/argo-helm"
   chart                     = "argo-cd"
   namespace                 = "argocd"
   version                   = var.chart_version
   create_namespace          = true
   values                    = [file("${path.module}/argocd.yaml")]
}
