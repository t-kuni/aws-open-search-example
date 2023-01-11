data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "example" {
  domain_name           = var.project_name_hyphen
  elasticsearch_version = "OpenSearch_2.3"

  access_policies       = jsonencode(
    {
      Statement = [
        {
          Action    = "es:*"
          Effect    = "Allow"
          Principal = {
            AWS = "*"
          }
          Resource  = "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.project_name_hyphen}/*"
        },
      ]
      Version   = "2012-10-17"
    }
  )
  advanced_options      = {
    "indices.fielddata.cache.size"        = "0"
    "indices.query.bool.max_clause_count" = "1024"
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.open_search_master_user_name
      master_user_password = var.open_search_master_user_password
    }
  }

  auto_tune_options {
    desired_state       = "DISABLED"
    rollback_on_disable = "NO_ROLLBACK"
  }

  cluster_config {
    dedicated_master_count   = 0
    dedicated_master_enabled = false
    instance_count           = 1
    instance_type            = "t3.small.elasticsearch"
    warm_enabled             = false
    zone_awareness_enabled   = false

    cold_storage_options {
      enabled = false
    }
  }

  domain_endpoint_options {
    custom_endpoint_enabled = false
    enforce_https           = true
    tls_security_policy     = "Policy-Min-TLS-1-0-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    iops        = 3000
    throughput  = 125
    volume_size = 10
    volume_type = "gp3"
  }

  encrypt_at_rest {
    enabled    = true
  }

  node_to_node_encryption {
    enabled = true
  }

  snapshot_options {
    automated_snapshot_start_hour = 0
  }

  tags                  = {}
  tags_all              = {}
}