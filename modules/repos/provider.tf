# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

terraform {
  required_version = ">= 1.8"
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.5.1"

      # GITEA_BASE_URL env var
      # GITEA_TOKEN env var
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.7.0"

      # GITLAB_TOKEN env var
    }
    github = {
      source  = "integrations/github"
      version = "6.4.0"

      # GITHUB_TOKEN env var
    }
    sourcehut = {
      source  = "wombelix/sourcehut"
      version = "0.2.0"

      # SRHT_TOKEN env var
    }
  }
}
