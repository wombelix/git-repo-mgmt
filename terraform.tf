# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

terraform {
  required_version = ">= 1.8"
  encryption {
    key_provider "aws_kms" "wombelix-sideprojects" {
      kms_key_id = "arn:${var.aws_partition}:kms:${var.aws_region}:${var.aws_account_id}:key/${var.aws_kms_name}"
      region     = var.aws_region
      key_spec   = "AES_256"
      assume_role = {
        role_arn = "arn:${var.aws_partition}:iam::${var.aws_account_id}:role/OpenTofuStateEncryptionRole"
      }
    }
    method "aes_gcm" "wombelix-sideprojects" {
      keys = key_provider.aws_kms.wombelix-sideprojects
    }
    state {
      method = method.aes_gcm.wombelix-sideprojects
    }
  }
  backend "s3" {
    bucket                  = var.aws_s3_bucket
    key                     = "opentofu-states/${var.project}/terraform.tfstate"
    region                  = var.aws_region
    skip_metadata_api_check = true
    encrypt                 = true
    kms_key_id              = "arn:${var.aws_partition}:kms:${var.aws_region}:${var.aws_account_id}:key/${var.aws_kms_name}"
    dynamodb_table          = "arn:${var.aws_partition}:dynamodb:${var.aws_region}:${var.aws_account_id}:table/iac-opentofu-remote-backend"
    assume_role = {
      role_arn = "arn:${var.aws_partition}:iam::${var.aws_account_id}:role/OpenTofuRemoteBackendRole"
    }
  }
}
