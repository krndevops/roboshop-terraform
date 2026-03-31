module "vpc" {
  source   = "git::https://github.com/krndevops/tf-module-vpc.git"
  for_each = var.vpc


  env          = var.env
  vpc_cidr     = each.value["vpc_cidr"]
  project_name = var.project_name


  public_subnets_cidr = each.value["public_subnets_cidr"]
  web_subnets_cidr    = each.value["web_subnets_cidr"]
  app_subnets_cidr    = each.value["app_subnets_cidr"]
  db_subnets_cidr     = each.value["db_subnets_cidr"]
  az                  = each.value["az"]

}


module "eks" {
  source   = "git::https://github.com/krndevops/tf-module-eks.git"
  for_each = var.eks


  env          = var.env
  component    = "eks"
  project_name = var.project_name
  subnet_ids   = lookup(lookup(module.vpc, "main", null), "app_subnets_id", null)
  node_groups  = each.value["node_groups"]



}