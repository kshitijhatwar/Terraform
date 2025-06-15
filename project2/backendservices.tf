resource "aws_db_subnet_group" "vprofile-rds-subgroup" {
  name       = "vprofile-rds-subgroup"
  subnet_ids = [module.ksh-vpc.private_subnets[0], module.ksh-vpc.private_subnets[1], module.ksh-vpc.private_subnets[2]]

}

resource "aws_db_instance" "vprofile-rds" {
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = var.dbname
  engine                 = "mysql"
  engine_version         = "8.0.41"
  instance_class         = "db.t3.micro"
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql8.0"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subgroup.name
  vpc_security_group_ids = [aws_security_group.vprofile-backend-sg.id]
}

#-------------------------------------------------------------------------
resource "aws_elasticache_subnet_group" "vprofile-ecache-subgroup" {
  name       = "vprofile-ecache-subgroup"
  subnet_ids = [module.ksh-vpc.private_subnets[0], module.ksh-vpc.private_subnets[1], module.ksh-vpc.private_subnets[2]]

}

resource "aws_elasticache_cluster" "vprofile-cache" {
  cluster_id           = "vprofile-cache"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
  security_group_ids   = [aws_security_group.vprofile-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-ecache-subgroup.name
}

#----------------------------------------------------------------------------------
resource "aws_mq_broker" "vprofile-rmq" {
  broker_name                = "vprofile-rmq"
  engine_type                = "RabbitMQ"
  engine_version             = "5.17.6"
  host_instance_type         = "mq.t3.micro"
  auto_minor_version_upgrade = true
  security_groups            = [aws_security_group.vprofile-backend-sg.id]
  subnet_ids                 = [module.ksh-vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}






