# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

# Trust Policy

data "aws_iam_policy_document" "trust" {
  count = var.enable_aws_iam_role ? 1 : 0

  statement {
    sid     = "GitHubOIDCTrust"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.aws_oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [local.github_oidc_subject]
    }
  }

  statement {
    sid     = "SSOAdminTrust"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:${var.aws_partition}:iam::${var.aws_account_id}:root"]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:PrincipalArn"
      values   = ["arn:${var.aws_partition}:iam::${var.aws_account_id}:role/aws-reserved/sso.amazonaws.com/*/AWSReservedSSO_AdministratorAccess_*"]
    }
  }
}

# IAM Role

resource "aws_iam_role" "github_oidc" {
  count = var.enable_aws_iam_role ? 1 : 0

  name                 = local.aws_role_name
  description          = "GitHub OIDC role for ${var.username}/${var.repo_name}"
  assume_role_policy   = data.aws_iam_policy_document.trust[0].json
  permissions_boundary = var.aws_permission_boundary_arn
  max_session_duration = 3600

  tags = local.aws_tags
}

# OpenTofu Backend Access

data "aws_iam_policy_document" "opentofu_backend" {
  count = var.enable_aws_iam_role && var.enable_aws_opentofu_backend ? 1 : 0

  statement {
    sid       = "S3ListBucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [local.s3_bucket_arn]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["${var.aws_s3_bucket_state_prefix}/${var.repo_name}/*"]
    }
  }

  statement {
    sid       = "S3StateAccess"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = [local.s3_state_path_arn]
  }

  statement {
    sid    = "DynamoDBLocking"
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [local.dynamodb_table_arn]
  }

  statement {
    sid    = "KMSPrimary"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext"
    ]
    resources = [local.kms_key_arn]
  }

  statement {
    sid    = "KMSReplica"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext"
    ]
    resources = [local.kms_key_replica_arn]
  }
}

resource "aws_iam_role_policy" "opentofu_backend" {
  count  = var.enable_aws_iam_role && var.enable_aws_opentofu_backend ? 1 : 0
  name   = "OpenTofuBackendAccess"
  role   = aws_iam_role.github_oidc[0].id
  policy = data.aws_iam_policy_document.opentofu_backend[0].json
}

# SSM Parameter Read Access

data "aws_iam_policy_document" "ssm_read" {
  count = var.enable_aws_iam_role && var.enable_aws_ssm_read ? 1 : 0

  statement {
    sid    = "SSMReadPrimary"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [local.ssm_path_primary]
  }

  statement {
    sid    = "SSMReadReplica"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [local.ssm_path_replica]
  }
}

resource "aws_iam_role_policy" "ssm_read" {
  count  = var.enable_aws_iam_role && var.enable_aws_ssm_read ? 1 : 0
  name   = "SSMParameterReadAccess"
  role   = aws_iam_role.github_oidc[0].id
  policy = data.aws_iam_policy_document.ssm_read[0].json
}

# Cross-Account Role Assumption

data "aws_iam_policy_document" "cross_account" {
  count = var.enable_aws_iam_role && var.enable_aws_cross_account_assume ? 1 : 0

  statement {
    sid       = "CrossAccountAssume"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:${var.aws_partition}:iam::*:role/${var.repo_name}-ProjectRole"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceOrgID"
      values   = [var.aws_organization_id]
    }
  }
}

resource "aws_iam_role_policy" "cross_account" {
  count  = var.enable_aws_iam_role && var.enable_aws_cross_account_assume ? 1 : 0
  name   = "CrossAccountAssumeRole"
  role   = aws_iam_role.github_oidc[0].id
  policy = data.aws_iam_policy_document.cross_account[0].json
}
