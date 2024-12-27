# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

variable "aws_region" {
  type        = string
  description = "AWS Region for tf encryption and backend"
}

variable "aws_partition" {
  type        = string
  default     = "aws"
  description = "AWS Partition for tf encryption and backend"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID for tf encryption and backend"
}

variable "aws_kms_name" {
  type        = string
  description = "AWS KMS name for tf encryption and backend"
}

variable "aws_s3_bucket" {
  type        = string
  description = "AWS S3 Bucket name for tf encryption and backend"
}

variable "project" {
  type        = string
  description = "OpenTofu IaC project name"
}
