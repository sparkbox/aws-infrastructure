output "initial-passwords" {
  value = {
    for profile in aws_iam_user_login_profile.user:
    profile.user => profile.encrypted_password
  }
}
