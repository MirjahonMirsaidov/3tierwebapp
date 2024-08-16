output "db_endpoint" {
  value = aws_db_instance.wr_db.endpoint
}

output "cache_endpoint" {
  value = aws_elasticache_cluster.prod_redis.configuration_endpoint
}
