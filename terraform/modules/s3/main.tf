resource "aws_cloudformation_stack" "bkt_valkyrie" {
  for_each = toset(local.s3_buckets)

  name = "stack-${each.value}"

  template_body = jsonencode({
    Resources = {
      Bucket = {
        Type = "AWS::S3::Bucket"
        Properties = {
          BucketName = each.value
          Tags       = [{ Key = "Name", Value = each.value }]
        }
      }
    }
    Outputs = {
      BucketName = { Value = { Ref = "Bucket" } }
    }
  })
}

resource "aws_s3_bucket_public_access_block" "bucket_acessos" {
  for_each = aws_cloudformation_stack.bkt_valkyrie

  bucket = each.value.outputs["BucketName"]

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "bkt_policy_acesso" {
  for_each = aws_cloudformation_stack.bkt_valkyrie

  bucket = each.value.outputs["BucketName"]
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        Resource  = "arn:aws:s3:::${each.value.outputs["BucketName"]}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.bucket_acessos]
}

resource "aws_s3_bucket_cors_configuration" "bkt-cors-config" {
  for_each = aws_cloudformation_stack.bkt_valkyrie

  bucket = each.value.outputs["BucketName"]
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}