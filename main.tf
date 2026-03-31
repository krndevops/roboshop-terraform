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
  source       = "git::https://github.com/krndevops/tf-module-eks.git"
  for_each     = var.eks


  env          = var.env
  component    = "eks"
  project_name = var.project_name
  subnet_ids   = lookup(lookup(module.vpc, "main", null), "app_subnets_id", null)
  node_groups  = each.value["node_groups"]



}


module "docdb" {
  source                 = "git::https://github.com/krndevops/tf-module-docdb.git"

  for_each               = var.docdb
  engine                 = each.value["engine"]
  engine_version         = each.value["engine_version"]
  instance_class         = each.value["instance_class"]
  parameter_group_family = each.value["parameter_group_family"]
  instance_count         = each.value["instance_count"]

  subnets                = lookup(lookup(module.vpc, "main", null), "db_subnets_id", null)
  vpc_id                 = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs               = lookup(lookup(var.vpc, "main", null), "app_subnets_cidr", null)


  project_name           = var.project_name
  env                    = var.env
  tags                   = {}
  kms                    = var.kms_key_id


}