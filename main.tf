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
