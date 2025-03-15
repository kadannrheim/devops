resource "aws_s3_bucket" "bucket" {
  #bucket = "devopstrain-bucket-kadann-3" // Измените это имя слегка, т.к. оно должно быть уникальным
  bucket = var.state_bucket  # или используем переменную state_bucket
    tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
#ещё один 
resource "aws_s3_bucket" "bucket-2" {
  bucket = "${var.second_bucket}-${terraform.workspace}"

  tags = {
    Name        = "Second Bucket"
    Environment = "Dev"
  }
}

# Используем рекомендованный bucket policy вместо ACL
# и настраиваем bucket policy без публичного доступа
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
resource "aws_s3_object" "object" { // Обратите внимание как мы обращаемся к другим ресурсам - через точку
  bucket = aws_s3_bucket.bucket.id // У ресурса aws_s3_bucket.bucket есть аттрибут .id 
  key    = "output.txt"  
  source = local_file.example.filename 
}

resource "aws_s3_bucket" "bucket-2" {
  bucket = "${var.second_bucket}-${terraform.workspace}"

}