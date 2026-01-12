# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
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
