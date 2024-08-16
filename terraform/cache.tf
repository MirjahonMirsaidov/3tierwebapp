# Create Subnet group
resource "aws_elasticache_subnet_group" "prod" {
  name       = "prod"
  subnet_ids = [
    aws_subnet.prod_us_east_1a_private.id,
    aws_subnet.prod_us_east_1b_private.id
  ]

  tags = {
    Name = "Prod"
  }
}


# Create Redis Elasticache cluster
resource "aws_elasticache_cluster" "prod_redis" {
  cluster_id           = "prod-redis"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  engine_version       = "7.1"
  port                 = 6379
  subnet_group_name = aws_elasticache_subnet_group.prod.name
}
