data "local_file" "pgp_key" {
  filename = var.pgp_path
}

/**********************************
* ORGANIZATION SPECIFIC RESOURCES *
**********************************/

data "aws_organizations_organization" "org" {}
data "aws_organizations_organizational_units" "root_ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "dev_team_ou" {
  name      = "Development Team"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

/**************************
* USER SPECIFIC RESOURCES *
***************************/

resource "aws_iam_user" "user" {
  for_each = toset(var.users)
  name = each.value
}

resource "aws_iam_user_login_profile" "user" {
  for_each = aws_iam_user.user
  user    = each.value.name
  pgp_key = data.local_file.pgp_key.content_base64
}

resource "aws_organizations_account" "account" {
  for_each  = aws_iam_user.user
  name      = "Dev Sandbox ${each.value.name}"
  email     = "ryan+aws_${each.value.name}@heysparkbox.com"
  role_name = "Administrator"
  parent_id = aws_organizations_organizational_unit.dev_team_ou.id
}

resource "aws_iam_role" "organization_account_access_role" {
  for_each  = aws_organizations_account.account
  name = "OrganizationAccountAccessRole-${each.value.id}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${each.value.id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_administrator_access" {
  for_each    = aws_iam_role.organization_account_access_role

  role       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "link_member_account_policy" {
  for_each    = aws_organizations_account.account

  name        = "LinkDevSandboxMemberAccountPolicy-${each.value.id}"
  description = "Allow Administrator access to the member account ${each.value.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::${each.value.id}:role/Administrator"
        }
    ]
}
EOF
}

/*
resource "aws_iam_user_policy_attachment" "attach_link_policy" {
  for_each   = aws_iam_user.user

  user       = each.value.name
  policy_arn = aws_iam_policy.link_member_account_policy.arn
}
*/

output "passwords" {
  value = aws_iam_user_login_profile.user
}
