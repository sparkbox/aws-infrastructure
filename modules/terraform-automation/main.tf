resource "aws_iam_user" "user" {
  name = "terraform-automation"
}

resource "aws_iam_access_key" "access_key" {
  user    = aws_iam_user.user.name
  pgp_key = var.pgp_key
}
