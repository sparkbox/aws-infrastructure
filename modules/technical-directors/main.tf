resource "aws_iam_group" "technical_directors" {
  name = "TechnicalDirectors"
}

resource "aws_iam_group_policy_attachment" "developers-change-password-policy" {
  group      = aws_iam_group.technical_directors.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "tech-directors-group-membership" {
  name = "TechnicalDirectorsGroupMembership"

  users = var.usernames
  group = aws_iam_group.technical_directors.name
}

