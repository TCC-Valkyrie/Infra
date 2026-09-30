# Bucket lido pela instância Python/ML (seta "Modelos" -> EC2 Python)
resource "aws_s3_bucket" "modelos" {
  bucket = "${var.project_name}-modelos-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-modelos"
  }
}

# Bucket lido e escrito pela instância Python/ML (setas duplas Python <-> Client)
resource "aws_s3_bucket" "client" {
  bucket = "${var.project_name}-client-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-client"
  }
}

# Bucket de dados tratados, usado pela instância Java/Angular
resource "aws_s3_bucket" "trusted" {
  bucket = "${var.project_name}-trusted-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-trusted"
  }
}

# Bucket de dados brutos, usado pela instância Java/Angular
resource "aws_s3_bucket" "raw" {
  bucket = "${var.project_name}-raw-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-raw"
  }
}

resource "aws_s3_bucket_versioning" "modelos" {
  bucket = aws_s3_bucket.modelos.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "client" {
  bucket = aws_s3_bucket.client.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "trusted" {
  bucket = aws_s3_bucket.trusted.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "modelos" {
  bucket                  = aws_s3_bucket.modelos.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "client" {
  bucket                  = aws_s3_bucket.client.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "trusted" {
  bucket                  = aws_s3_bucket.trusted.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "raw" {
  bucket                  = aws_s3_bucket.raw.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}