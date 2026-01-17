# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
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

# AWS IAM Role Feature Toggles

variable "enable_aws_iam_role" {
  type        = bool
  default     = false
  description = "Create AWS IAM role with GitHub OIDC trust for this repository"

  validation {
    condition = (
      !var.enable_aws_iam_role || (
        var.enable_aws_opentofu_backend ||
        var.enable_aws_ssm_read ||
        var.enable_aws_cross_account_assume
      )
    )
    error_message = "When enable_aws_iam_role is true, at least one feature must be enabled (enable_aws_opentofu_backend, enable_aws_ssm_read, or enable_aws_cross_account_assume)."
  }
}

variable "enable_aws_opentofu_backend" {
  type        = bool
  default     = false
  description = "Grant access to OpenTofu remote backend (S3, DynamoDB, KMS)"
}

variable "enable_aws_ssm_read" {
  type        = bool
  default     = false
  description = "Grant read access to SSM parameters at /projects/{repo_name}/*"
}

variable "enable_aws_cross_account_assume" {
  type        = bool
  default     = false
  description = "Grant permission to assume {repo_name}-ProjectRole in organization accounts"
}

variable "enable_aws_ssh_key" {
  type        = bool
  default     = false
  description = "Generate ephemeral SSH key and store in SSM Parameter Store"

  validation {
    condition = (
      !var.enable_aws_ssh_key ||
      !var.enable_aws_iam_role ||
      var.enable_aws_ssm_read
    )
    error_message = "When enable_aws_ssh_key and enable_aws_iam_role are both true, enable_aws_ssm_read must also be true so the IAM role can read the generated keys."
  }
}

variable "aws_ssh_key_algorithm" {
  type        = string
  default     = "ED25519"
  description = "SSH key algorithm: ED25519 (recommended) or RSA"

  validation {
    condition     = contains(["ED25519", "RSA"], var.aws_ssh_key_algorithm)
    error_message = "aws_ssh_key_algorithm must be either ED25519 or RSA."
  }
}

variable "aws_ssh_key_version" {
  type        = number
  default     = 1
  description = "Version number for SSH key rotation. Increment to trigger key regeneration."

  validation {
    condition     = var.aws_ssh_key_version >= 1
    error_message = "aws_ssh_key_version must be >= 1."
  }
}

# AWS Configuration

variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = "Primary AWS region"
}

variable "aws_region_replica" {
  type        = string
  default     = "eu-west-1"
  description = "Replica AWS region for multi-region KMS/SSM"
}

variable "aws_partition" {
  type        = string
  default     = "aws"
  description = "AWS partition"
}

variable "aws_account_id" {
  type        = string
  default     = "992382418145"
  description = "AWS account ID"
}

variable "aws_organization_id" {
  type        = string
  default     = "o-37w8eaobo2"
  description = "AWS Organization ID for cross-account role assumption"
}

variable "aws_s3_bucket" {
  type        = string
  default     = "dominik-wombacher-iac-opentofu"
  description = "S3 bucket for OpenTofu state"
}

variable "aws_s3_bucket_state_prefix" {
  type        = string
  default     = "opentofu-states"
  description = "S3 prefix for state files"
}

variable "aws_dynamodb_table" {
  type        = string
  default     = "dominik-wombacher-iac-opentofu"
  description = "DynamoDB table for state locking"
}

variable "aws_kms_key_id" {
  type        = string
  default     = "mrk-9888e66a1d1d4d4c8c92b2a3d3cd2b85"
  description = "KMS key ID for state encryption"
}

variable "aws_oidc_provider_arn" {
  type        = string
  default     = "arn:aws:iam::992382418145:oidc-provider/token.actions.githubusercontent.com"
  description = "ARN of the GitHub OIDC identity provider"
}

variable "aws_permission_boundary_arn" {
  type        = string
  default     = "arn:aws:iam::992382418145:policy/GitRepoMgmtPermissionBoundary"
  description = "ARN of the permission boundary for created roles"
}
