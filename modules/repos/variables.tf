# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

variable "username" {
  type        = string
  default     = "wombelix"
  description = "Username on git forges"
}

variable "repo_name" {
  type        = string
  description = "Name of the repository"
}

variable "description" {
  type        = string
  description = "Description of the repository"
}

variable "website" {
  type        = string
  default     = "https://dominik.wombacher.cc"
  description = "Website to link from repository"
}

variable "primary_platform" {
  type        = string
  default     = "sourcehut"
  description = "Primary platform (sourcehut, github, gitlab, codeberg)"
  validation {
    condition     = contains(["sourcehut", "github", "gitlab", "codeberg"], var.primary_platform)
    error_message = "Primary platform must be one of: sourcehut, github, gitlab, codeberg."
  }
  validation {
    condition = (
      (var.primary_platform == "sourcehut" && var.enable_sourcehut) ||
      (var.primary_platform == "github" && var.enable_github) ||
      (var.primary_platform == "gitlab" && var.enable_gitlab) ||
      (var.primary_platform == "codeberg" && var.enable_codeberg)
    )
    error_message = "The primary_platform must be enabled (corresponding enable_* variable must be true)."
  }
}

variable "archived" {
  type        = bool
  default     = false
  description = "Whether the repository should be archived"
}

variable "enable_sourcehut" {
  type        = bool
  default     = true
  description = "Create repository on Sourcehut"
}

variable "enable_github" {
  type        = bool
  default     = true
  description = "Create repository on GitHub"
}

variable "enable_gitlab" {
  type        = bool
  default     = true
  description = "Create repository on GitLab"
}

variable "enable_codeberg" {
  type        = bool
  default     = true
  description = "Create repository on Codeberg"
}
