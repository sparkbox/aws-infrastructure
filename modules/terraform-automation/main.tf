resource "aws_iam_user" "user" {
  name = "terraform-automation"
}

resource "aws_iam_access_key" "access_key" {
  user    = aws_iam_user.user.name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy" "terraform-user-iam-access-policy" {
  user = aws_iam_user.user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:*User",
        "iam:*Group",
        "iam:GetLoginProfile",
        "iam:ListAttachedGroupPolicies",
        "iam:ListAccessKeys",
        "iam:ListAttachedGroupPolicies",
        "organizations:ListRoots",
        "organizations:ListAccounts",
        "organizations:DescribeOrganization",
        "organizations:ListOrganizationalUnitsForParent",
        "organizations:ListAWSServiceAccessForOrganization"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
