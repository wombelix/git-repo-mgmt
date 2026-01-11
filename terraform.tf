# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_version = ">= 1.8"
  encryption {
    key_provider "aws_kms" "dominik-wombacher" {
      kms_key_id = "arn:${var.aws_partition}:kms:${var.aws_region}:${var.aws_account_id}:key/${var.aws_kms_name}"
      region     = var.aws_region
      key_spec   = "AES_256"
    }
    method "aes_gcm" "dominik-wombacher" {
      keys = key_provider.aws_kms.dominik-wombacher
    }
    state {
      method = method.aes_gcm.dominik-wombacher
    }
  }
  backend "s3" {
    bucket                  = var.aws_s3_bucket
    key                     = "${var.aws_s3_bucket_state_prefix}/${var.project}/terraform.tfstate"
    region                  = var.aws_region
    skip_metadata_api_check = true
    encrypt                 = true
    kms_key_id              = "arn:${var.aws_partition}:kms:${var.aws_region}:${var.aws_account_id}:key/${var.aws_kms_name}"
    dynamodb_table          = "arn:${var.aws_partition}:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.aws_dynamodb_table}"
  }
}
