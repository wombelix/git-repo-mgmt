# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

terraform {
  required_version = ">= 1.8"
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"

      # GITEA_BASE_URL env var
      # GITEA_TOKEN env var
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "18.2.0"

      # GITLAB_TOKEN env var
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"

      # GITHUB_TOKEN env var
    }
    sourcehut = {
      source  = "wombelix/sourcehut"
      version = "0.2.1"

      # SRHT_TOKEN env var
    }
  }
}
