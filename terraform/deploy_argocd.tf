module "argocd_dev" {
   source       = "./terraform_argocd_eks"
   eks_cluster_name = "k8s-cluster-test10"
   chart_version = "5.46.2" 
}


module "argocd_dev_root" {
  source = "./terraform_argocd_root_eks"
  eks_cluster_name = "k8s-cluster-test10"
  git_source_path = "demo-dev/applications"
  git_source_repoURL = "git@github.com:miatey/argocd.git"

# Вказуємо залежність від модуля "argocd_dev"
#  depends_on = [module.argocd_dev]

}

