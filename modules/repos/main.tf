# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

locals {
  description = "${var.description}. Mirror of ${var.mirror_of_base}/${var.repo_name}"
}

# Sourcehut
resource "sourcehut_repository" "sourcehut" {
  name        = var.repo_name
  description = var.description
  visibility  = "public"
}

# Codeberg.org mirror
resource "gitea_repository" "codeberg" {
  name              = var.repo_name
  username          = var.username
  auto_init         = false
  description       = local.description
  has_issues        = true
  has_projects      = false
  has_pull_requests = true
  has_wiki          = false
  private           = false
  website           = var.website
}

# Gitlab.com mirror
resource "gitlab_project" "gitlab" {
  name                            = var.repo_name
  analytics_access_level          = "disabled"
  auto_devops_enabled             = false
  builds_access_level             = "disabled"
  container_registry_access_level = "disabled"
  description                     = local.description
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
}

# GitHub.com mirror
resource "github_repository" "github" {
  name            = var.repo_name
  description     = local.description
  homepage_url    = var.website
  visibility      = "public"
  has_issues      = true
  has_discussions = false
  has_projects    = false
  has_wiki        = false
  auto_init       = false
}
