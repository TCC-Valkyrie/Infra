data "aws_caller_identity" "current" {}

locals {
  id_conta = data.aws_caller_identity.current.account_id

  s3_buckets = [
    "bkt-valkyrie-raw-${local.id_conta}",
    "bkt-valkyrie-trusted-${local.id_conta}",
    "bkt-valkyrie-client-${local.id_conta}",
  ]
}
