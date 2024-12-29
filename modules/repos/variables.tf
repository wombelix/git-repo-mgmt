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

variable "mirror_of_base" {
  type        = string
  default     = "https://git.sr.ht/~wombelix"
  description = "Base URL of primary git forge"
}
