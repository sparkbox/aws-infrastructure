output "secret" {
  value = aws_iam_access_key.access_key.encrypted_secret
}
