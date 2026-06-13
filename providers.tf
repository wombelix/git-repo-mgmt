# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "18.7.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.9.0"
    }
    sourcehut = {
      source  = "wombelix/sourcehut"
      version = "1.0.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "gitea" {
  # GITEA_BASE_URL env var
  # GITEA_TOKEN env var
}

provider "gitlab" {
  # GITLAB_TOKEN env var
}

provider "github" {
  # GITHUB_TOKEN env var
}

provider "sourcehut" {
  # SRHT_TOKEN env var
}

provider "aws" {
  # AWS_REGION, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY env vars
  # or GitHub OIDC role assumption
}

provider "tls" {}
