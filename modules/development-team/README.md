# AWS Infrastructure - Development Team Provisioning

The Development Team module provisions development team AWS accounts, including
sandbox member accounts in the Development Team organizational unit.

## Background
Sparkbox uses [AWS Organizations] to manage multiple AWS accounts, including
developer sandbox accounts (member accounts) that can be used to learn,
experiment, and deploy resources. All billing is managed by the Sparkbox Main
account. This Main account also applies some policies applied to member
accounts.

## Current Configuration
Sparkbox team members each have an account in the Sparkbox Main Account. Most
do not have many or any permissions within this account. The Account is not
meant to host resources. It is simply a place to manage billing and other
accounts in the organization.

Each Developer Sandbox Account has a role called Administrator. Sparkbox team
member accounts are given permission to assume the Administrator role in
their own developer sandbox account following the configuration guidance for
["Accessing and administering the member accounts in your organization"][Accssing Member Accounts]. (_Note: AWS guides recommend the role within member accounts be
"OrganizationAccountAccessRole", but we use "Administrator"_).

## Accessing Developer Sandbox

**Sign into Sparkbox' Main AWS Account**

1. You'll receive an email with your initial, one-time password.
2. Visit https://sparkbox.signin.aws.amazon.com/console to sign in. You will be
required to create a new password. We recommend generating and
storing this password using 1Password.


**Switch Role**
You have your own AWS account which is unique to you in which you can
experiment and deploy with AWS services.
[Switch to that account as an administrator][Switch to Account]. 

* `Account` should be the ID for your Sandbox account which you should receive
with your credentials.
* `Role` should be `Administrator`
* `Display name` is anything of your choosing, though we recommend _Sparkbox
Sandbox Account_

You now have the ability to create new resources under your account, while
billing is managed by the Sparkbox Main Account. Budget alerts are configured,
but we still encourage you to use Free Tier services unless you talk with a
Technical Director.



[AWS Organizations]: https://docs.aws.amazon.com/organizations/?id=docs_gateway
[Accessing Member Accounts]: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html
[Switch to Account]: https://signin.aws.amazon.com/switchrole?roleName=Administrator&account=
