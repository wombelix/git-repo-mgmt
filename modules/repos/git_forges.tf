# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

locals {
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
}

# Sourcehut
resource "sourcehut_repository" "sourcehut" {
  count       = var.enable_sourcehut ? 1 : 0
  name        = var.repo_name
  description = local.descriptions.sourcehut
  visibility  = "public"
}

# Codeberg.org mirror
resource "gitea_repository" "codeberg" {
  count              = var.enable_codeberg ? 1 : 0
  name               = var.repo_name
  username           = var.username
  auto_init          = false
  description        = local.descriptions.codeberg
  has_issues         = true
  has_projects       = false
  has_pull_requests  = true
  has_wiki           = false
  private            = false
  website            = var.website
  archived           = var.archived
  archive_on_destroy = false
}

# Gitlab.com mirror
resource "gitlab_project" "gitlab" {
  count                           = var.enable_gitlab ? 1 : 0
  name                            = var.repo_name
  analytics_access_level          = "disabled"
  auto_devops_enabled             = false
  builds_access_level             = "disabled"
  container_registry_access_level = "disabled"
  description                     = local.descriptions.gitlab
  environments_access_level       = "disabled"
  feature_flags_access_level      = "disabled"
  infrastructure_access_level     = "disabled"
  initialize_with_readme          = false
  issues_access_level             = "enabled"
  lfs_enabled                     = false
  merge_requests_access_level     = "enabled"
  model_experiments_access_level  = "disabled"
  model_registry_access_level     = "disabled"
  monitor_access_level            = "disabled"
  packages_enabled                = false
  path                            = var.repo_name
  snippets_access_level           = "disabled"
  visibility_level                = "public"
  wiki_access_level               = "disabled"
  archived                        = var.archived
}

# GitHub.com mirror
resource "github_repository" "github" {
  count           = var.enable_github ? 1 : 0
  name            = var.repo_name
  description     = local.descriptions.github
  homepage_url    = var.website
  visibility      = "public"
  has_issues      = true
  has_discussions = false
  has_projects    = false
  has_wiki        = false
  auto_init       = false
  archived        = var.archived
}

# State migration: moved blocks to handle transition from non-count to count resources
moved {
  from = sourcehut_repository.sourcehut
  to   = sourcehut_repository.sourcehut[0]
}

moved {
  from = gitea_repository.codeberg
  to   = gitea_repository.codeberg[0]
}

moved {
  from = gitlab_project.gitlab
  to   = gitlab_project.gitlab[0]
}

moved {
  from = github_repository.github
  to   = github_repository.github[0]
}
