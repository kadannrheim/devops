resource "aws_s3_bucket" "bucket" { #создание бакета
  bucket = var.state_bucket  # Используем переменную state_bucket
  depends_on = [module.vpc]  # Явно указываем зависимость
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "second_bucket" {
  bucket = "${var.second_bucket}-${terraform.workspace}"  # Добавляем workspace в имя бакета
  tags = {
    Name        = "Second Bucket"
    Environment = "Dev"
  }
}

# Используем рекомендованный bucket policy вместо ACL
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::571600838708:root"  # ARN своего пользователя или роли
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "output.txt"
  source = local_file.example.filename
}