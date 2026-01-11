# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

variable "aws_region" {
  type        = string
  description = "AWS Region to use"
  default     = "eu-central-1"
}

variable "aws_partition" {
  type        = string
  description = "AWS Partition to use"
  default     = "aws"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID with tf remote backend and state encryption resources"
  default     = "992382418145"
}

variable "aws_kms_name" {
  type        = string
  description = "AWS KMS name for tf encryption"
  default     = "mrk-9888e66a1d1d4d4c8c92b2a3d3cd2b85"
}

variable "aws_s3_bucket" {
  type        = string
  description = "AWS S3 Bucket name for tf remote backend"
  default     = "dominik-wombacher-iac-opentofu"
}

variable "aws_s3_bucket_state_prefix" {
  type        = string
  description = "AWS S3 Bucket prefix for tf states"
  default     = "opentofu-states"
}

variable "aws_dynamodb_table" {
  type        = string
  description = "AWS DynamoDB Table name for tf backend locking"
  default     = "dominik-wombacher-iac-opentofu"
}

variable "project" {
  type        = string
  description = "OpenTofu IaC project name"
  default     = "git-repo-mgmt"
}
