env = "dev"
project_name = "roboshop"
kms_key_id = "arn:aws:kms:us-east-1:367241114876:key/b0eaa327-c037-47e6-93ed-78b8b08219b9"
bastion_cidrs = ["172.31.65.60/32"]
prometheus_cidrs = ["172.31.64.139/32"]
acm_arn = "arn:aws:acm:us-east-1:367241114876:certificate/d39a082e-653d-4d86-a528-226eeba031d2"
zone_id = "Z0266758558URTEO39RC"

vpc = {
  main = {
    vpc_cidr            = "10.10.0.0/21"
    public_subnets_cidr = ["10.10.0.0/25", "10.10.0.128/25"]
    web_subnets_cidr    = ["10.10.1.0/25", "10.10.1.128/25"]
    app_subnets_cidr    = ["10.10.2.0/25", "10.10.2.128/25"]
    db_subnets_cidr     = ["10.10.3.0/25", "10.10.3.128/25"]
    az                  = ["us-east-1a", "us-east-1b"]
  }
}

eks = {
  main = {
    node_groups = {
      n1 = {

        size = 1
        instance_types = ["t3.large"]
        capacity_type  = "SPOT"

      }
    }
  }
}

docdb = {
  main = {
    engine                 = "docdb"
    engine_version         = "4.0.0"
    instance_class         = "db.t3.medium"
    parameter_group_family = "docdb4.0"
    instance_count         = 1
  }
}

elasticache = {
  main = {
    engine                 = "redis"
    engine_version         = "6.2"
    node_type              = "cache.t3.micro"
    parameter_group_family = "redis6.x"
    num_cache_nodes        = 1
  }
}

rabbitmq = {
  main = {
    instance_type = "t3.small"
  }
}

rds = {
  main = {
    allocated_storage      = 20
    engine                 = "mysql"
    engine_version         = "5.7.44-rds.20250103"
    instance_class         = "db.m5.large"
    parameter_group_family = "mysql5.7"
  }
}

