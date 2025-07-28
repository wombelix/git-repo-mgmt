# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

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
    github    = local.base_descriptions.github
    gitlab    = local.base_descriptions.gitlab
    codeberg  = local.base_descriptions.codeberg
  }
}

# Sourcehut
resource "sourcehut_repository" "sourcehut" {
  name        = var.repo_name
  description = local.descriptions.sourcehut
  visibility  = "public"
}

# Codeberg.org mirror
resource "gitea_repository" "codeberg" {
  name              = var.repo_name
  username          = var.username
  auto_init         = false
  description       = local.descriptions.codeberg
  has_issues        = true
  has_projects      = false
  has_pull_requests = true
  has_wiki          = false
  private           = false
  website           = var.website
  archived          = var.archived
}

# Gitlab.com mirror
resource "gitlab_project" "gitlab" {
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
  issues_enabled                  = true
  lfs_enabled                     = false
  merge_requests_enabled          = true
  model_experiments_access_level  = "disabled"
  model_registry_access_level     = "disabled"
  monitor_access_level            = "disabled"
  packages_enabled                = false
  path                            = var.repo_name
  snippets_enabled                = false
  visibility_level                = "public"
  wiki_enabled                    = false
  archived                        = var.archived
}

# GitHub.com mirror
resource "github_repository" "github" {
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
