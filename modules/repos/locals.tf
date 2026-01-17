# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

locals {
  # Git Forge URLs and Descriptions

  platform_urls = {
    sourcehut = "https://git.sr.ht/~${var.username}"
    github    = "https://github.com/${var.username}"
    gitlab    = "https://gitlab.com/${var.username}"
    codeberg  = "https://codeberg.org/${var.username}"
  }

  primary_url = local.platform_urls[var.primary_platform]

  base_descriptions = {
    sourcehut = var.primary_platform == "sourcehut" ? var.description : "${var.description}. Mirror of ${local.primary_url}/${var.repo_name}"
    github    = var.primary_platform == "github" ? var.description : "${var.description}. Mirror of ${local.primary_url}/${var.repo_name}"
    gitlab    = var.primary_platform == "gitlab" ? var.description : "${var.description}. Mirror of ${local.primary_url}/${var.repo_name}"
    codeberg  = var.primary_platform == "codeberg" ? var.description : "${var.description}. Mirror of ${local.primary_url}/${var.repo_name}"
  }

  descriptions = {
    sourcehut = var.archived ? "[ARCHIVED] ${local.base_descriptions.sourcehut}" : local.base_descriptions.sourcehut
    github    = var.archived ? "[ARCHIVED] ${local.base_descriptions.github}" : local.base_descriptions.github
    gitlab    = var.archived ? "[ARCHIVED] ${local.base_descriptions.gitlab}" : local.base_descriptions.gitlab
    codeberg  = var.archived ? "[ARCHIVED] ${local.base_descriptions.codeberg}" : local.base_descriptions.codeberg
  }

  # AWS IAM Role

  # Role name must match permission boundary pattern: GitHubOIDC-*-ResourceAccess
  aws_role_name = "GitHubOIDC-${var.repo_name}-ResourceAccess"

  # GitHub OIDC subject for main branch
  github_oidc_subject = "repo:${var.username}/${var.repo_name}:ref:refs/heads/main"

  # Common tags for all AWS resources
  aws_tags = {
    Repository  = "${var.username}/${var.repo_name}"
    Creator     = "OpenTofu"
    Environment = "Production"
    Lifecycle   = "Active"
    DoNotDelete = "True"
  }

  # Resource ARNs
  s3_bucket_arn      = "arn:${var.aws_partition}:s3:::${var.aws_s3_bucket}"
  s3_state_path_arn  = "arn:${var.aws_partition}:s3:::${var.aws_s3_bucket}/${var.aws_s3_bucket_state_prefix}/${var.repo_name}/*"
  dynamodb_table_arn = "arn:${var.aws_partition}:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.aws_dynamodb_table}"

  kms_key_arn         = "arn:${var.aws_partition}:kms:${var.aws_region}:${var.aws_account_id}:key/${var.aws_kms_key_id}"
  kms_key_replica_arn = "arn:${var.aws_partition}:kms:${var.aws_region_replica}:${var.aws_account_id}:key/${var.aws_kms_key_id}"

  ssm_path_primary = "arn:${var.aws_partition}:ssm:${var.aws_region}:${var.aws_account_id}:parameter/projects/${var.repo_name}/*"
  ssm_path_replica = "arn:${var.aws_partition}:ssm:${var.aws_region_replica}:${var.aws_account_id}:parameter/projects/${var.repo_name}/*"

  # SSH Key SSM Paths
  ssh_key_public_path  = "/projects/${var.repo_name}/ssh-key-pub"
  ssh_key_private_path = "/projects/${var.repo_name}/ssh-key"
}
