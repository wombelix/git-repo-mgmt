<!--
SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>

SPDX-License-Identifier: Apache-2.0
-->

# Git repository management

OpenTofu based management of my git repositories at Sourcehut
with mirrors at Codeberg, Gitlab and GitHub.

[![REUSE status](https://api.reuse.software/badge/git.sr.ht/~wombelix/git-repo-mgmt)](https://api.reuse.software/info/git.sr.ht/~wombelix/git-repo-mgmt)
[![builds.sr.ht status](https://builds.sr.ht/~wombelix/git-repo-mgmt.svg)](https://builds.sr.ht/~wombelix/git-repo-mgmt?)

## Table of Contents

* [Usage](#usage)
* [AWS IAM Role Integration](#aws-iam-role-integration)
* [SSH Key Generation](#ssh-key-generation)
* [Source](#source)
* [Contribute](#contribute)
* [License](#license)

## Usage

To interact with AWS (S3 Backend and KMS encryption) and the various git forges,
the following Environment variables have to be set:

```
AWS_REGION
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
GITEA_BASE_URL
GITEA_TOKEN
GITLAB_TOKEN
GITHUB_TOKEN
SRHT_TOKEN
TF_VAR_aws_region
TF_VAR_aws_account_id
TF_VAR_aws_kms_name
TF_VAR_aws_s3_bucket
TF_VAR_project
```

By default, Sourcehut is used as the primary repository with mirrors on
Codeberg, Gitlab and GitHub. To use a different platform as primary
(e.g., GitHub for GitHub Actions), set the `primary_platform` variable:

```hcl
module "my-github-repo" {
  source           = "./modules/repos"
  repo_name        = "my-project"
  description      = "My project description"
  primary_platform = "github"
}
```

Supported primary platforms:
`sourcehut` (default), `github`, `gitlab`, `codeberg`.

To create a repository only on specific platforms,
use the `enable_*` variables:

```hcl
module "github-only-repo" {
  source           = "./modules/repos"
  repo_name        = "my-project"
  description      = "A GitHub-only project"
  primary_platform = "github"
  enable_github    = true
  enable_sourcehut = false
  enable_gitlab    = false
  enable_codeberg  = false
}
```

Or create a repository on GitHub with mirrors
on GitLab and Codeberg (without Sourcehut):

```hcl
module "github-with-mirrors" {
  source           = "./modules/repos"
  repo_name        = "my-project"
  description      = "GitHub primary with GitLab and Codeberg mirrors"
  primary_platform = "github"
  enable_github    = true
  enable_sourcehut = false
  enable_gitlab    = true
  enable_codeberg  = true
}
```

All platforms are enabled through the variables
`enable_sourcehut`, `enable_github`,
`enable_gitlab`, `enable_codeberg` by default (set to `true`).

To archive a repository, set the `archived` parameter:

```hcl
module "archived-repo" {
  source      = "./modules/repos"
  repo_name   = "old-project"
  description = "Legacy project no longer maintained"
  archived    = true
}
```

Archived repositories are read-only on GitHub, GitLab and Codeberg.
Sourcehut doesn't support archiving, so an `[ARCHIVED]` prefix is added
to the description on all platforms.

## AWS IAM Role Integration

The `repo` module can create an AWS IAM role with GitHub OIDC trust for CI/CD workflows.
This enables GitHub Actions to assume the role without storing long-lived credentials.

```hcl
module "repo-with-aws" {
  source      = "./modules/repos"
  repo_name   = "my-project"
  description = "Project with AWS integration"

  # Enable IAM role (requires at least one feature below)
  enable_aws_iam_role         = true
  enable_aws_opentofu_backend = true  # Access to OpenTofu state (S3, DynamoDB, KMS)
  enable_aws_ssm_read         = true  # Read SSM parameters at /projects/{repo_name}/*
  enable_aws_cross_account_assume = false
}
```

Available IAM features, all disabled by default:

* `enable_aws_opentofu_backend` - Grants access to S3 state bucket,
  DynamoDB lock table, and KMS encryption key
* `enable_aws_ssm_read` - Grants read access to SSM parameters
  under `/projects/{repo_name}/*`
* `enable_aws_cross_account_assume` - Allows assuming
  `{repo_name}-ProjectRole` in organization accounts

## SSH Key Generation

Generate SSH keys stored in AWS SSM Parameter Store.
Keys are created using OpenTofu ephemeral resources, ensuring private keys
never appear in state files or plan output.

```hcl
module "repo-with-ssh-key" {
  source      = "./modules/repos"
  repo_name   = "my-project"
  description = "Project with SSH key for deployments"

  # Enable SSH key generation
  enable_aws_ssh_key    = true
  aws_ssh_key_algorithm = "ED25519"  # or "RSA" for 4096-bit RSA
  aws_ssh_key_version   = 1          # Increment to rotate key

  # Required when using with IAM role
  enable_aws_iam_role = true
  enable_aws_ssm_read = true
}
```

Keys are stored at:

* `/projects/{repo_name}/ssh-key` - Private key (SecureString, KMS encrypted)
* `/projects/{repo_name}/ssh-key-pub` - Public key (String)

Keys are replicated to both primary (eu-central-1) and replica (eu-west-1) regions.

To rotate a key, increment `aws_ssh_key_version`:

```hcl
aws_ssh_key_version = 2  # Triggers key regeneration
```

To manage already existing repositories, use
`tofu import 'module.<modulename>.<resource>[0]' <resourcename>`, example:
`tofu import 'module.tmp-opentofu-test-repo.sourcehut_repository.sourcehut[0]' tmp-opentofu-test-repo`

## Source

The primary location is:
[git.sr.ht/~wombelix/git-repo-mgmt](https://git.sr.ht/~wombelix/git-repo-mgmt)

Mirrors are available on
[Codeberg](https://codeberg.org/wombelix/git-repo-mgmt),
[Gitlab](https://gitlab.com/wombelix/git-repo-mgmt)
and
[GitHub](https://github.com/wombelix/git-repo-mgmt).

## Contribute

Please don't hesitate to provide feedback,
open an issue, or create a Pull / Merge Request.

Just pick the workflow or platform you prefer and are most comfortable with.

Feedback, bug reports, or patches sent to my sr.ht list
[~wombelix/inbox@lists.sr.ht](https://lists.sr.ht/~wombelix/inbox) or via
[Email and Instant Messaging](https://dominik.wombacher.cc/pages/contact.html)
are also always welcome.

## License

Unless otherwise stated: `Apache 2.0`

All files contain license information either as a
`header comment` or a `corresponding .license` file.

[REUSE](https://reuse.software) from the [FSFE](https://fsfe.org/)
is implemented to verify license and copyright compliance.
