# Версия с AWS, продолжение v4 (копия с v5-aws-count)
## "Terraform на практике(AWS)"
### Задание начиная с 15. Разделение кода на логические части

Не завершено, проблема с бакетом. Создал на UI, но теперь нужно выпились из конфигов. Удаляю бакет, сыпется конфиг.
Ошибка:
```
│ Error: creating S3 Bucket (devopstrain-bucket-kadannr): operation error S3: CreateBucket, https response error StatusCode: 409, RequestID: Q25RHJJPRG15Y7H6, HostID: +KRJeOtCYpzS0q+bqznjCic1W9SGebSQe55J8EFYWPBCqbMssvGNXDAKwsTedEnwP2keix8Rn9Q=, BucketAlreadyOwnedByYou: 
│ 
│   with aws_s3_bucket.bucket,
│   on s3.tf line 1, in resource "aws_s3_bucket" "bucket":
│    1: resource "aws_s3_bucket" "bucket" {
```