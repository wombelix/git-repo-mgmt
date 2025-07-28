# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

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
}
