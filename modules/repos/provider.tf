# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_version = ">= 1.11.2"
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"

      # GITEA_BASE_URL env var
      # GITEA_TOKEN env var
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "18.7.0"

      # GITLAB_TOKEN env var
    }
    github = {
      source  = "integrations/github"
      version = "6.9.0"

      # GITHUB_TOKEN env var
    }
    sourcehut = {
      source  = "wombelix/sourcehut"
      version = "1.0.1"

      # SRHT_TOKEN env var
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"

      # AWS_REGION, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY env vars
      # or GitHub OIDC role assumption
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "aws" {
  alias  = "replica"
  region = var.aws_region_replica
}

# Management account, account vending and ProjectRole stack instances
provider "aws" {
  alias  = "vending"
  region = var.aws_region

  assume_role {
    role_arn     = var.aws_account_vending_role_arn
    session_name = "git-repo-mgmt-${var.repo_name}"
  }
}
